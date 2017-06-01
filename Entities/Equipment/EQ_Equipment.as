
#include "EQ_Functions.as"



namespace EQ {
  EQ::Manager@ onInit( CBlob@ _this, Factory_fptr@ _Foo, EQ_ITEM::Item _item, string _name  ) {
    CRules@ rules = getRules();
    if( rules == null || ! rules.hasTag("EQ")) {
      error("ERROR: Getting The Rules Failed Or The Rules Don't Have The Tag 'EQ'! -> 'EQ::onInit");
      error("       ( remember to add 'EQ_Hooks.as;' to 'scripts' in 'gamemode.cfg' )");
      return null;
    }
    EQ::Manager@ eqm;
    rules.get( "EQM", @eqm );
    eqm.Register( @_Foo, _item, _name );
    // Þetta ER hluturinn sjálfur... ekki playerinn???   mad bru
    return eqm;
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
}//EQ
