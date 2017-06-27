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
  /* OLD FUNCTION::::::::::::
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
  */
  
  // CBitStream:
  bool Make_new_in_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream:
  bool Make_new_in_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream: u16 EQ_ITEM::Item, Vec2f Pos.
  bool Make_new_in_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    EQ_ITEM::Item type = EQ_ITEM::Item( _params.read_u16());
    Vec2f pos = _params.read_Vec2f();
    EQ::b_Item@ new_item = _eqm.Make_item( type );
    new_item.m_state = EQ_STATE::NIL;
    _params.Clear();
    _params.write_u32( new_item.Get_index());
    _params.write_Vec2f( pos );
    _params.ResetBitIndex();
    return Move_to_world( _eqm, _this, _params );
  }

  // CBitStream: 
  bool Move_to_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream: 
  bool Move_to_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream: u32 EQ-Item-index, Vec2f Pos.
  bool Move_to_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    uint index = _params.read_u32();
    Vec2f pos = _params.read_Vec2f();
    EQ::b_Item@ item = _eqm.Get_item( index );
    if( item.Get_state() != EQ_STATE::NIL ) {
      error("EQ ERROR: Item's State Not Right, Remove Item First! ->'"+ getCurrentScriptName() +"'->'EQ::Move_to_world'");
      return false;
    }
    CBlob@ item_blob = server_CreateBlob( EQ_ITEM::g_str[ item.Get_type() ], -1, pos );
    if( @item_blob == null ) {
      error("EQ ERROR: Server Failed To Create Blob! ->'"+ getCurrentScriptName() +"'->'EQ::Move_to_world'");
      return false;
    }
    item.m_state = EQ_STATE::WORLD;
    item_blob.Tag("EQ");
    item_blob.set("EQ_ITEM", @item );
    item_blob.AddScript("EQ_Item_logic_world.as");
    return true;
  }
  
  // CBitStream: 
  bool Remove_from_equip( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream: 
  bool Remove_from_storage( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    return false;
  }
  // CBitStream: u32 EQ-Item-index, u16 Blob's-NetworkID.
  bool Remove_from_world( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    uint index = _params.read_u32();
    CBlob@ item_blob = getBlobByNetworkID( _params.read_u16());
    if( @item_blob == null ) {
      error("EQ ERROR: Failed Getting Blob By Networkid! ->'"+ getCurrentScriptName() +"'->'EQ::Remove_from_world'");
      return false;
    }
    EQ::b_Item@ item = _eqm.Get_item( index );
    if( item.Get_state() != EQ_STATE::WORLD ) {
      error("EQ ERROR: Item's State Not Right! ->'"+ getCurrentScriptName() +"'->'EQ::Remove_from_world'");
      return false;
    }  
    item_blob.Tag("EQ_MOVING");
    item.m_state = EQ_STATE::NIL;
    item_blob.server_Die();
    return true;
  }
  
  // CBitStream: u32 EQ-Item-index.
  bool Kill( EQ::Manager@ _eqm, CRules@ _this, CBitStream@ _params ) {
    if( ! _eqm.Delete_item( _params.read_u32())) {
      error("EQ ERROR: Failed the Delete Item! ->'"+ getCurrentScriptName() +"'->'EQ::Kill'");
      return false;
    }
    return true;
  }
}//EQ



#endif
