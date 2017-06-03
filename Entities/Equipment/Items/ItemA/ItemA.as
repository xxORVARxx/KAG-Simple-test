
#include "EQ_Item_Common.as"



namespace EQ {
  class c_Item_A : EQ::b_Item {
    // --- CONSTRUCTORS ---
    c_Item_A() {
      m_slots = EQ_SLOT::Slot(EQ_SLOT::HEAD | EQ_SLOT::BODY);
    }
    // --- METHODS ---
    void onInit( CBlob@ _this ) {
    }
    void onTick( CBlob@ _this ) {
    }
    void onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
    }
    void onDie( CBlob@ _this ) {
    }
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ



// Factory Function:
EQ::b_Item@ Factory_function() {
  return EQ::c_Item_A();
}



// Registering Item:
void onCommand( CBlob@ _this, u8 _cmd, CBitStream@ _params ) {
  if( _cmd == EQ_CMD::REGISTER ) {
    EQ::Register_item( _this, @Factory_function, EQ_ITEM::ITEM_A );
  }
}
