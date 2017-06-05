
#ifndef EQ2_INTERFACE_AS
#define EQ2_INTERFACE_AS

#include "EQ1_Types.as"



namespace EQ {
  // Interface Class:
  interface i_Item {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    EQ_ITEM::Item Get_type();
    void Set_type( const EQ_ITEM::Item _item ); // Only For Manager.
    uint Get_index();
    void Set_index( const uint _i ); // Only For Manager.
    EQ_SLOT::Slot Get_slots();
    EQ_CLASS::Class Get_classes();
    EQ_STATE::State Get_state();
    bool Fits_slot( const EQ_SLOT::Slot _slot );
    bool Fits_class( const EQ_CLASS::Class _class );
    // World Hooks:
    void World_onInit( CBlob@ _this );
    void World_onTick( CBlob@ _this );
    void World_onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 );
    f32 World_onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, const f32 _original_damage, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data );
    void World_onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, const f32 _original_damage, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data );
    void World_onHealthChange( CBlob@ _this, f32 _oldHealth );
    void World_onDie( CBlob@ _this, CRules@ _rules );
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ



namespace EQ {
  // Base/default Class:
  class b_Item : EQ::i_Item {
    // --- CONSTRUCTORS ---
    // The Factory Will Only Use The Default Constructor.
    // --- METHODS ---
    EQ_ITEM::Item Get_type() {
      return m_type;
    }
    void Set_type( const EQ_ITEM::Item _item ) {
      if( m_type == EQ_ITEM::NIL )
	m_type = _item;
    }
    uint Get_index() {
      return m_index;
    }
    void Set_index( const uint _i ) {
      if( m_index == -1 )
	m_index = _i;
    }
    EQ_SLOT::Slot Get_slots() {
      return m_slots;
    }
    EQ_CLASS::Class Get_classes() {
      return m_classes;
    }
    EQ_STATE::State Get_state() {
      return m_state;
    }
    bool Fits_slot( const uint _slot ) {
      return this.Fits_slot( EQ_SLOT::Slot(_slot) );
    }
    bool Fits_slot( const EQ_SLOT::Slot _slot ) {
      return ( m_slots & _slot ) != 0;
    }
    bool Fits_class( const uint _class ) {
      return this.Fits_class( _class );
    }
    bool Fits_class( const EQ_CLASS::Class _class ) {
      return ( m_classes & _class ) != 0;
    }
    // World Hooks:
    void World_onInit( CBlob@ _this ) {
    }
    void World_onTick( CBlob@ _this ) {
    }
    void World_onCollision( CBlob@ _this, CBlob@ _blob, bool _solid, Vec2f _normal, Vec2f _point1, Vec2f _point2 ) {
    }
    f32 World_onHit( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, const f32 _original_damage, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
      return _damage;
    }
    void World_onHitBlob( CBlob@ _this, Vec2f _world_point, Vec2f _velocity, const f32 _original_damage, f32 _damage, CBlob@ _hitter_blob, u8 _custom_data ) {
    }
    void World_onHealthChange( CBlob@ _this, f32 _oldHealth ) {
    }
    void World_onDie( CBlob@ _this, CRules@ _rules ) {
    }
    
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
    private EQ_ITEM::Item m_type = EQ_ITEM::NIL;
    private uint m_index = -1;
    EQ_SLOT::Slot m_slots = EQ_SLOT::NIL;
    EQ_CLASS::Class m_classes = EQ_CLASS::NIL;
    EQ_STATE::State m_state = EQ_STATE::NIL; //<- Read Only.
  }
}//EQ



#endif
