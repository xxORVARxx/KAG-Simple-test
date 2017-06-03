
#ifndef EQ_ITEM_COMMON_AS
#define EQ_ITEM_COMMON_AS

#include "EQ3_Manager.as";



namespace EQ {
  void Register_item( CBlob@ _this, Factory_fptr@ _Foo, EQ_ITEM::Item _item ) {
    print("EQ: Registereing Item: '"+ EQ_ITEM::g_str[_item] +"'...");
    EQ::Manager@ eqm = null;
    CRules@ rules = getRules();
    if( rules == null || ! rules.hasTag("EQ")) {
      error("ERROR: Getting The Rules Failed Or The Rules Don't Have The Tag 'EQ'! ->'EQ_Item_Common.as'->'EQ::Register_item'");
      error("       ( remember to add 'EQ_Rules.as;' to 'scripts' in 'gamemode.cfg' )");
      return;
    }
    rules.get( "EQM", @eqm );
    if( eqm == null ) {
      error("ERROR: Failed To Get The Equipment Manager! ->'EQ_Item_Common.as'->'EQ::Register_item'");
      return;
    }
    if( ! eqm.Register( @_Foo, _item )) {
      error("ERROR: Register Fail! ->'EQ_Item_Common.as'->'EQ::Register_item'");
      return;
    }
    print("    Success...");
  }
}//EQ



void onInit( CBlob@ _this ) {
}

void onTick( CBlob@ _this ) {
}

void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
}

f32 onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
  return 0.0f;
}

void onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
}

void onHealthChange( CBlob@ _this, f32 _oldHealth ) {
}
 
void onDie( CBlob@ _this ) {
}



#endif
