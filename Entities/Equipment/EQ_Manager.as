
#ifndef EQ_MANAGER_AS
#define EQ_MANAGER_AS
 
#include "EQ_Interface.as"



namespace EQ {
  funcdef EQ::b_Item@ Factory_fptr();

  class Manager {
    // --- CONSTRUCTORS ---
    // --- METHODS ---
    void Register( Factory_fptr@ _Foo, EQ_ITEM::Item _item, string _name ) {
      if( m_factory[_item] != null ) {
	error("ERROR: Registering The Item '"+ _name +"' More Than Once! -> 'EQ::Manager::Register'");
	return;
      }
      m_factory[_item] = _Foo;
      m_item_names[_item] = _name;
      m_item_ids.set( _name, _item );
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
    EQ_ITEM::Item Get_id( const string _name ) {
      int64 item = 0;
      m_item_ids.get( _name, item );
      return EQ_ITEM::Item(item);
    }
    string Get_name( const EQ_ITEM::Item _id ) {
      return m_item_names[_id];
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
	error("ERROR: Item Already Removed Or Out Of Boundary! -> 'EQ::Manager::Remove_item'");
	return;
      }
      @m_items[_i] = null;
    }   
    // --- VARIABLES ---
    private array<EQ::Factory_fptr@> m_factory( EQ_ITEM::END, null );
    private array<EQ::i_Item@> m_items;
    private array<string> m_item_names( EQ_ITEM::END, "" );
    private dictionary m_item_ids;
  }
}//EQ



#endif



// Equip An Item
