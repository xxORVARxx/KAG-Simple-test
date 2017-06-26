/*
 *  only used be the server thru the rules..
 * 
 */

#ifndef EQ4_RULES_FUNCTIONS_AS
#define EQ4_RULES_FUNCTIONS_AS

#include "EQ3_Manager.as"


/*
namespace EQ {
  EQ_ITEM::Item g_global_spawn_item = EQ_ITEM::NIL;
  EQ_ITEM::Item g_class_spawn_item = EQ_ITEM::NIL;
  EQ_ITEM::Item g_player_spawn_item = EQ_ITEM::NIL;
}//EQ
namespace EQ {
  void Set_global_spawn_item() {
  }
  void Set_class_spawn_item() {
  }
  void Set_player_spawn_item() {
  }
}//EQ
*/



namespace EQ {
  bool Make_new( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) { 
    CBlob@ caller = getBlobByNetworkID( _params.read_u16());    
    EQ_ITEM::Item id = EQ_ITEM::Item( _params.read_u16());
    EQ_STATE::State state = EQ_STATE::State( _params.read_u16());
    if( @caller == null || id >= EQ_ITEM::END || state >= EQ_STATE::END ) {
      error("EQ ERROR: Failed To Read 'CBitStream'! ->'EQ4_Rules_functions.as'->'EQ::Make_new'");
      return false;
    }    
    EQ::b_Item@ new_item = _eqm.Make_item( id );
    new_item.m_state = state;
    if( state == EQ_STATE::WORLD ) {
      //CBlob@ item_blob = server_CreateBlob( EQ_ITEM::g_str[id] );
      CBlob@ item_blob = server_CreateBlob( EQ_ITEM::g_str[id], -1, caller.getPosition());
      item_blob.Tag("EQM_CREATED");
      item_blob.set("EQ_ITEM", @new_item );
      item_blob.AddScript("EQ_Item_logic_world.as");

      //caller.server_SetQuantity( 1 );
      //caller.server_PutInInventory( item_blob );
       //caller.server_Pickup( item_blob );
    }
    else if( state == EQ_STATE::EQUIPT ) {

    }
    else if( state == EQ_STATE::STORAGE ) {

    }
    else {
      error("EQ ERROR: Item's State Not Right! ->'EQ4_Rules_functions.as'->'EQ::Make_new'");
      return false;
    }
    return true;
  }

  bool Move_to_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Move_to_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  /*
  bool Move_to_inventory( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  */
  bool Move_to_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Remove_from_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }

  bool Remove_from_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  /*
  bool Remove_from_inventory( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  */
  bool Remove_from_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
    
  bool Kill( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    if( ! _eqm.Delete_item( _params.read_u32())) {
      error("EQ ERROR: Failed the Delete Item! ->'EQ4_Rules_functions.as'->'EQ::Kill'");
      return false;
    }
    return true;
  }
}//EQ



#endif
