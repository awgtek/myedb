<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Type.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Property.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Property_Type.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Entity_Property.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Entity.php');

class Glue
{
	var $the_type_name;
	var $the_type_id;
	var $prop_ids;
	var $prop_id_prop_obj_hash;
	var $ent_prop_3dhash;
	var $eid;
	var $eids;
	var $prop_ids_num_extra;

/*	function set_type_id_from_type_name($type_name)
	{
		$this->the_type_id = Type::get_type_id($type_name);
	}
	*/

	//fill base datastructure based on type's properties. ent_prop_3dhash is fleshed out based on this property collection
	function set_type_frame($type_id)
	{
		$this->set_type_id($type_id);
		$this->set_prop_ids();
		$this->set_prop_id_prop_obj_hash();
	}

	function set_type_id($type_id)
	{
		$this->the_type_id = $type_id;
	}

	function set_prop_ids()
	{
		$this->prop_ids = Property_Type::get_prop_ids($this->the_type_id);
	}

	function set_prop_id_prop_obj_hash()
	{
		foreach ($this->prop_ids as $id)
		{
			$this->prop_id_prop_obj_hash[$id] = new Property($id);
		}
	}

	function set_ent_prop_3dhash($eid)
	{
		foreach ($this->prop_id_prop_obj_hash as $prop_obj)
		{
			$prop_name = $prop_obj->get_table_name();
			$prop_id = $prop_obj->prop_id;

			$prop_class_name = str_replace("_prop","_Prop",ucfirst($prop_name));
			include_once (dirname(__FILE__) ."/../Props/{$prop_class_name}.php");

			//below I instantiate concrete property objects (e.g. varchar_prop) without actually naming
			//the object. I consider this to be a valid form of the Factory design pattern, because
			//the actual property class isn't hard coded (except for the conventional _prop suffix)
			$sql = "select ron, entity_property.ent_prop_id from entity_property inner
			join {$prop_name} on entity_property.ent_prop_id =
			{$prop_name}.ent_prop_id
			where eid='$eid' and prop_id = '$prop_id' order by ron";//echo $sql;
			$result = mysql_query($sql) or die ("ERROR:kj2dfk");
			$prop_rons = -1;
			$unset_property = false;
			while($ar = mysql_fetch_array($result)){
				$gen_prop = new $prop_class_name(
					$ar['ent_prop_id'], $prop_id );
				$this->ent_prop_3dhash[$prop_id][$ar['ron']]= $gen_prop;
				$prop_rons = $ar['ron']; //ron sequence may skip if a ron is deleted, e.g. sequence maybe  1,2,4,5
			}
			if ($prop_rons==-1) //$eid not found, so set up empty property, with '0' indicating empty=>possible new record
			{
				//$unset_property = true; //not sure what this is for - Adam George 2009-04-05
				$prop_rons = 0; //start at zero
				$gen_prop = new $prop_class_name(0, $prop_id);
				$this->ent_prop_3dhash[$prop_id][$prop_rons]=$gen_prop;
			}
			if ($this->prop_ids_num_extra[$prop_id] && !$unset_property)
			{
				for ($i=0; $i<$this->prop_ids_num_extra[$prop_id]; $i++)
				{
					$prop_rons++;
					$gen_prop = new $prop_class_name(0, $prop_id);
					$this->ent_prop_3dhash[$prop_id][$prop_rons]=$gen_prop;
				}
			}
		}
		$this->add_any_missing_row_fields();
		return $this->ent_prop_3dhash;
	}

	function add_any_missing_row_fields()
	{
		$group_rons = array(); //two dim array holding the row numbers (rons) that should exist per group
		//collect row numbers
		foreach ($this->prop_id_prop_obj_hash as $prop_obj)
		{
			$prop_id = $prop_obj->prop_id;
			$prop_group_id = $prop_obj->prop_group_id;
			if ($prop_group_id)
			{
				if (!isset($group_rons[$prop_group_id]))
				{
					$group_rons[$prop_group_id] = array();
				}
				foreach ($this->ent_prop_3dhash[$prop_id] as $cur_ron => $cur_prop_obj)
				{
					$group_rons[$prop_group_id][$cur_ron] = 1;
				}
			}
		}
		//fill in any blanks
		foreach ($this->prop_id_prop_obj_hash as $prop_obj)
		{
			$prop_id = $prop_obj->prop_id;
			$prop_group_id = $prop_obj->prop_group_id;
			if ($prop_group_id)
			{
				foreach ($group_rons[$prop_group_id] as $fin_ron => $gbg)
				{
					if (!isset($this->ent_prop_3dhash[$prop_id][$fin_ron]))
					{
						$prop_name = $prop_obj->get_table_name();
						$prop_class_name = str_replace("_prop","_Prop",ucfirst($prop_name));
						$gen_prop = new $prop_class_name(0, $prop_id);
						$this->ent_prop_3dhash[$prop_id][$fin_ron]=$gen_prop;
					}
				}
			}
		}
	}

	function set_ent_prop_3dhash_from_post()
	{//assumes Main has set the correct type id in Record that corresponds to the posted values!
		$roni = 0;
		foreach ($_REQUEST as $postkey => $postval)
		{
			if (ereg("^pi([0-9]+)epi([0-9]+)ron([0-9]+)$",$postkey,$regs))
			{
				$prop_id = $regs[1];
				$ent_prop_id = $regs[2];
				$roni = $regs[3];
				$prop_name = Property::get_table_name($prop_id);
				$prop_class_name = str_replace("_prop","_Prop",ucfirst($prop_name));
				include_once (dirname(__FILE__) ."/../Props/{$prop_class_name}.php");
				$gen_prop = new $prop_class_name(
					$ent_prop_id, $prop_id );
				$this->ent_prop_3dhash[$prop_id][$roni]= $gen_prop;
			}

		}
	}

	function commit_updates_from_ent_prop_3dhash()
	{
		$modified_flag = false;
		foreach ($this->ent_prop_3dhash as $prop_id => $ron)
		{
			$newgrouprons = array();
		  foreach ($ron as $roni => $prop_obj )
		  {
			  // add node for each row
		//	  $roni = 0; //ron index
			//  $prop_obj = $ron[$roni];
				//if ($prop_obj->my_ent_prop_id == 0 and !$newentityset):
				$prop = new Property($prop_id);
				if (!$this->eid):
					$this->eid = Entity::create_new($this->the_type_id);
					$_REQUEST['eid'] = $this->eid;  //necessary to remain on same edit page when inserting //echo "in glue: ".$_REQUEST['eid']."<br>";
					$modified_flag = true;
				endif;
				if (!$modified_flag):
					Entity::set_last_modified_date($this->eid);
					$modified_flag = true;
				endif;

				$postedvalue = trim($_REQUEST["pi".$prop_id."epi".$prop_obj->my_ent_prop_id."ron".$roni]);
				if ($prop_obj->my_ent_prop_id == 0 and ($prop->prop_group_id and //my_ent_prop_id == 0 =>nonexisting prop
							$this->commit_all_new_grouped_props($prop->prop_group_id,$roni,$newgrouprons)))://is a "grouped" property
					$new_ent_prop_id = Entity_Property::create_new($this->eid,$roni)	;
					$prop_obj->create_new($postedvalue,$prop_id,$new_ent_prop_id);
				elseif ($prop_obj->my_ent_prop_id == 0 and !empty($postedvalue)):
					$new_ent_prop_id = Entity_Property::create_new($this->eid,$roni)	;
					$prop_obj->create_new($postedvalue,$prop_id,$new_ent_prop_id);
				else:
					$prop_obj->update($postedvalue,$prop_id,$prop_obj->my_ent_prop_id);
				endif;

		  }
		}
	}

	function set_prop_ids_num_extra_by_group_id($group_id)
	{
		$prop_ids = Property::get_prop_ids_by_group_id($group_id);
		foreach ($prop_ids as $prop_id)
		{
			$this->prop_ids_num_extra[$prop_id]++;
		}

	}

	//function to indicate whether the particular collection (determined by group) of posted values
	//should be committed, depending on whether any of the values in the collection is not empty
	function commit_all_new_grouped_props($group_id, $ron, &$newgrouprons)
	{
		if (isset($newgrouprons[$group_id][$ron]) && $newgrouprons[$group_id][$ron])
			return true;
		$prop_ids = Property::get_prop_ids_by_group_id($group_id);
		foreach ($prop_ids as $prop_id)
		{
			if (!empty($_POST["pi".$prop_id."epi0"."ron".$ron]))
			{
				$newgrouprons[$group_id][$ron] = true;
				return true;
			}
		}
		return false;
	}
}


?>