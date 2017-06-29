/*
 * list this file in the '.cfg' files for all the EQ items
 *
 */

#ifndef EQ_ITEM_LOGIC_WORLD_AS
#define EQ_ITEM_LOGIC_WORLD_AS

#include "EQ4_Item_functions.as"



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HOOKS FOR ALL EQ-ITEMS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void onInit( CBlob@ _this ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
    // This Function Cant Be Used To Do The EQ-Item's 'World_onInit' Function Call, Because
    // The EQ-Item Haven't Been 'Set' To this CBlob At The Time This Function Is Happening.
    // So EQ-Item's 'World_onInit' Function Is Call in 'EQ4_Rules_functions.as'->'Move_to_world'.
  }
}

void onTick( CBlob@ _this ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
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
}

void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
  }  
}

f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  return _damage;
}

void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
  }
}

void onHealthChange( CBlob@ _this, f32 _oldHealth ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
  }
}
 
void onDie( CBlob@ _this ) {
  if( getNet().isServer() && _this.hasTag("EQ")) {
    CRules@ rules = getRules();
    if( @rules == null ) {
      error("EQ ERROR: Getting The Rules Failed! ->'"+ getCurrentScriptName() +"'->'onDie'");
      return;
    }
    EQ::b_Item@ item = null;
    _this.get("EQ_ITEM", @item );
    if( @item == null ) {
      error("EQ ERROR: Getting The EQ-Item Failed! ->'"+ getCurrentScriptName() +"'->'onDie'");
      return;
    }
    if( item.Get_state() == EQ_STATE::WORLD ) {
      item.World_onDie( _this, rules );
      CBitStream params;
      params.write_u32( item.Get_index());
      rules.SendCommand( EQ_CMD::KILL, params );
    }
  }
}



#endif
