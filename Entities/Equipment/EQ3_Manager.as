
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
    bool Register( Factory_fptr@ _Foo, EQ_ITEM::Item _item ) {
      if( m_factory[_item] != null ) {
	error("ERROR: Registering The Item '"+ EQ_ITEM::g_str[_item] +"' More Than Once! ->'EQ_Manager.as'->'EQ::Manager::Register'");
	return false;
      }
      m_factory[_item] = _Foo;
      return true;
    }
    EQ::b_Item@ Make_item( const EQ_ITEM::Item _id ) {
      Factory_fptr@ fptr = m_factory[_id];
      EQ::b_Item@ item = fptr();
      this.Insert_item( @item );
      return item;
    }
    void Delete_item( EQ::b_Item@ _item ) {
      this.Remove_item( _item.Get_index());
    }
    // --- PRIVATE-METHODS ---
    private void Insert_item( EQ::b_Item@ _item ) {
      for( uint i = 0 ; i < m_items.length() ; ++i ) {
	if( m_items[i] == null ) {
	  _item.Set_index( i );
	  @m_items[i] = @_item;
	  return;
	}
      }//for
      m_items.insertLast( @_item );
    }
    private void Remove_item( uint _i ) {
      if( _i > m_items.length() || m_items[_i] != null ) {
	error("ERROR: Item Already Removed Or Index Out Of Boundary! ->'EQ_Manager.as'->'EQ::Manager::Remove_item'");
	return;
      }
      @m_items[_i] = null;
    }   
    // --- VARIABLES ---
    private array<EQ::Factory_fptr@> m_factory( EQ_ITEM::END, null );
    private array<EQ::i_Item@> m_items;  }
}//EQ



#endif



// Equip An Item
