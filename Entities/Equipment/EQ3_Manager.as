
#ifndef EQ3_MANAGER_AS
#define EQ3_MANAGER_AS
 
#include "EQ2_Interface.as"



namespace EQ {
  funcdef EQ::b_Item@ Factory_fptr();
}//EQ



namespace EQ {
  class Manager {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    const array<EQ::Factory_fptr@>@ Get_factory_array() {
      return m_factory;
    }
    bool Register( Factory_fptr@ _Foo, EQ_ITEM::Item _item_type ) {
      if( @m_factory[ _item_type ] != null ) {
	error("EQ ERROR: Registering The Item '"+ EQ_ITEM::g_str[ _item_type ] +"' More Than Once! ->'"+ getCurrentScriptName() +"'->'EQ::Manager::Register'");
	return false;
      }
      m_factory[ _item_type ] = _Foo;
      return true;
    }
    EQ::b_Item@ Make_item( const EQ_ITEM::Item _item_type ) {
      Factory_fptr@ fptr = m_factory[ _item_type ];
      EQ::b_Item@ item = fptr();
      item.Set_type( _item_type );
      this.Insert_item( @item );
      return item;
    }
    bool Delete_item( const uint _index ) {
      if( _index > m_items.length() || @m_items[ _index ] == null ) {
	error("EQ ERROR: Index Out Of Boundary Or Item Already Removed! ->'"+ getCurrentScriptName() +"'->'EQ::Manager::Delete_item'");
	return false;
      }
      @m_items[ _index ] = null;
      return true;
    }
    EQ::b_Item@ Get_item( const uint _index ) {
      if( _index > m_items.length() || @m_items[ _index ] == null ) {
	error("EQ ERROR: Index Out Of Boundary Or Item Already Removed! ->'"+ getCurrentScriptName() +"'->'EQ::Manager::Get_item'");
	return null;
      }
      return m_items[ _index ];
    }
    // --- PRIVATE-METHODS ---
    private void Insert_item( EQ::b_Item@ _item ) {
      for( uint i = 0 ; i < m_items.length() ; ++i ) {
	if( @m_items[i] == null ) {
	  _item.Set_index( i );
	  @m_items[i] = @_item;
	  return;
	}
      }//for
      _item.Set_index( m_items.length());
      m_items.insertLast( @_item );
    }  
    // --- VARIABLES ---
    private array<EQ::Factory_fptr@> m_factory( EQ_ITEM::END, null );
    private array<EQ::b_Item@> m_items;
  }
}//EQ



#endif



// Equip An Item
