
#ifndef EQ2_INTERFACE_AS
#define EQ2_INTERFACE_AS

#include "EQ1_Types.as"



namespace EQ {
  // Interface Class:
  interface i_Item {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    uint Get_index();
    void Set_index( uint _i );
    EQ_SLOT::Slot Get_slots();
    EQ_CLASS::Class Get_classes();
    bool Fits_slot( const EQ_SLOT::Slot _slot );
    bool Fits_class( const EQ_CLASS::Class _class );
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
  }
}//EQ



namespace EQ {
  // Base/default Class:
  class b_Item : EQ::i_Item {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    uint Get_index() {
      return m_index;
    }
    void Set_index( uint _i ) {
      if( m_index == -1 )
	m_index = _i;
    }
    EQ_SLOT::Slot Get_slots() {
      return m_slots;
    }
    EQ_CLASS::Class Get_classes() {
      return m_classes;
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
    // --- PRIVATE-METHODS ---
    // --- VARIABLES ---
    private uint m_index = -1;
    EQ_SLOT::Slot m_slots = EQ_SLOT::NIL;
    EQ_CLASS::Class m_classes = EQ_CLASS::NIL;
    EQ_STATE::State m_state = EQ_STATE::NIL;
  }
}//EQ



#endif
