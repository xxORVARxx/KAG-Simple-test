/*
 * list this file in the '.cfg' files for all the EQ items
 *
 */

#ifndef EQ_ITEM_LOGIC_WORLD_AS
#define EQ_ITEM_LOGIC_WORLD_AS

#include "EQ4_Item_functions.as"



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HOOKS FOR ALL EQ-ITEMS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void onInit( CBlob@ _this ) {
  EQ::b_Item@ item = null;
  _this.get("EQ_ITEM", @item );
  if( @item == null ) {
    error("EQ ERROR: Getting The EQ-Item Failed! ->'EQ_Item_logic_world.as'->'onInit'");
    return;
  }
  if( item.Get_state() == EQ_STATE::WORLD )
    item.World_onInit( _this );
  else
    error("EQ ERROR: Expected 'EQ_STATE::WORLD' Not 'EQ_STATE::"+ EQ_STATE::g_str[ item.Get_state() ] +"' For Item '"+ EQ_ITEM::g_str[ item.Get_type() ] +"'! ->'EQ4_Item_logic_world.as'->'onInit'");
}

void onTick( CBlob@ _this ) {
  EQ::b_Item@ item = null;
  _this.get("EQ_ITEM", @item );
  if( @item == null ) {
    error("EQ ERROR: Getting The EQ-Item Failed! ->'EQ_Item_logic_world.as'->'onTick'");
    return;
  }
  if( item.Get_state() == EQ_STATE::WORLD )
    item.World_onTick( _this );
  else
    error("EQ ERROR: Expected 'EQ_STATE::WORLD' Not 'EQ_STATE::"+ EQ_STATE::g_str[ item.Get_state() ] +"' For Item '"+ EQ_ITEM::g_str[ item.Get_type() ] +"'! ->'EQ4_Item_logic_world.as'->'onTick'");
}

void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
}

f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  return _damage;
}

void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
}

void onHealthChange( CBlob@ _this, f32 _oldHealth ) {
}
 
void onDie( CBlob@ _this ) {
  if( _this.hasTag("EQM_CREATED")) {
    CRules@ rules = getRules();
    if( @rules == null ) {
      error("EQ ERROR: Getting The Rules Failed! ->'EQ4_Item_logic_world.as'->'onDie'");
      return;
    }
    EQ::b_Item@ item = null;
    _this.get("EQ_ITEM", @item );
    if( @item == null ) {
      error("EQ ERROR: Getting The EQ-Item Failed! ->'EQ_Item_logic_world.as'->'onDie'");
      return;
    }
    item.World_onDie( _this, rules );
    CBitStream params;
    params.write_u32( item.Get_index());
    rules.SendCommand( EQ_CMD::KILL, params );
  }
}



#endif
