
#include "EQ4_Item_functions.as"



// Factory-Function:
EQ::b_Item@ Factory_function() {
  // Return THIS EQ-Item, But Disguised As 'EQ::b_Item' (base-class item):
  return EQ::c_Test_green(); // <---- HERE!
}

// Command To Register Item's 'Factory-Function' With The EQ-Manager:
void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) {
  // This Call Will Come From 'EQ_Rules_register.as' When The First Player Joins The Game:
  if( _cmd == EQ_CMD::REGISTER ) {
    EQ::Register_item( @Factory_function, EQ_ITEM::TEST_GREEN ); // <---- HERE!
    _this.server_Die();
  }
}



// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LOGIC FOR THIS EQ-ITEM ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

namespace EQ {
  class c_Test_green : EQ::b_Item { // <---- HERE!
    // --- CONSTRUCTORS ---
    c_Test_green() { // <---- HERE!
      m_slots = EQ_SLOT::Slot(EQ_SLOT::HEAD | EQ_SLOT::BODY);
    }    
    // --- METHODS ---
    
    // Equip Hooks:
    void Equip_onInit( CBlob@ _this ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onInit.");
    }
    void Equip_onTick( CBlob@ _this ) override {
      //print("----------------FROM EQ::c_Test_green::Equip_onTick."); 
    }
    void Equip_onCollision( CBlob@ _this,
			    CBlob@ _blob,
			    bool _solid,
			    Vec2f _normal,
			    Vec2f _point1,
			    Vec2f _point2 ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onCollision.");
    }
    f32 Equip_onHit( CBlob@ _this,
		     Vec2f _world_point,
		     Vec2f _velocity,
		     const f32 _original_damage,
		     f32 _damage,
		     CBlob@ _hitter_blob,
		     u8 _custom_data ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onHit.");
      return _damage;
    }
    void Equip_onHitBlob( CBlob@ _this,
			  Vec2f _world_point,
			  Vec2f _velocity,
			  const f32 _original_damage,
			  f32 _damage,
			  CBlob@ _hitter_blob,
			  u8 _custom_data ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onHitBlob.");
    }
    void Equip_onHealthChange( CBlob@ _this,
			       f32 _oldHealth ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onHealthChange.");
    }
    void Equip_onDie( CBlob@ _this,
		      CRules@ _rules ) override {
      print("----------------FROM EQ::c_Test_green::Equip_onDie.");
    }
   
    // World Hooks:
    void World_onInit( CBlob@ _this ) override {
      print("----------------FROM EQ::c_Test_green::World_onInit.");
    }
    void World_onTick( CBlob@ _this ) override {
      //print("----------------FROM EQ::c_Test_green::World_onTick."); 
    }
    void World_onCollision( CBlob@ _this,
			    CBlob@ _blob,
			    bool _solid,
			    Vec2f _normal,
			    Vec2f _point1,
			    Vec2f _point2 ) override {
      print("----------------FROM EQ::c_Test_green::World_onCollision.");
    }
    f32 World_onHit( CBlob@ _this,
		     Vec2f _world_point,
		     Vec2f _velocity,
		     f32 _damage,
		     CBlob@ _hitter_blob,
		     u8 _custom_data ) override {
      print("----------------FROM EQ::c_Test_green::World_onHit.");
      return _damage;
    }
    void World_onHitBlob( CBlob@ _this,
			  Vec2f _world_point,
			  Vec2f _velocity,
			  f32 _damage,
			  CBlob@ _hitter_blob,
			  u8 _custom_data ) override {
      print("----------------FROM EQ::c_Test_green::World_onHitBlob.");
    }
    void World_onHealthChange( CBlob@ _this,
			       f32 _oldHealth ) override {
      print("----------------FROM EQ::c_Test_green::World_onHealthChange.");
    }
    void World_onDie( CBlob@ _this,
		      CRules@ _rules ) override {
      print("----------------FROM EQ::c_Test_green::World_onDie.");
    }
    
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ
