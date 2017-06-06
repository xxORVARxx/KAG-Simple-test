
#include "EQ1_Types.as"



void onInit( CBlob@ _this ) {
  _this.Tag("B");
   
  CBlob@ parent = null;
  _this.set("parent", @parent );
  
  _this.addCommandID("kill");
  _this.addCommandID("EQ_ITEM");
}



void onTick( CBlob@ _this ) {

}



void GetButtonsFor( CBlob@ _this, CBlob@ _caller ) {
  if( _this.hasTag("B") && _this.isOverlapping( _caller )) {
    print("Hello From B");
    CButton@ button1 = _caller.CreateGenericButton( "$B$", //<- Icon Token.
						    Vec2f( -5.0f, -6.0f ), //<- Button Offset.
						    _this, //<- Button Attachment.
						    _this.getCommandID("kill"), //<- Command ID.
						    "Kill"); //<- Description
    CButton@ button2 = _caller.CreateGenericButton( "$B$", //<- Icon Token.
						    Vec2f( 5.0f, -6.0f ), //<- Button Offset.
						    _this, //<- Button Attachment.
						    _this.getCommandID("EQ_ITEM"), //<- Command ID.
						    "Get Green Test EQ-Item!"); //<- Description
    if( @button1 != null )
      button1.enableRadius = 16.0f;
    if( @button2 != null )
      button2.enableRadius = 16.0f;
  }
}



void onCommand( CBlob@ _this_B, u8 _cmd, CBitStream@ _params ) {
  if( _cmd == _this_B.getCommandID("kill")) {
    _this_B.server_Die();
  }
  else if( _cmd == _this_B.getCommandID("EQ_ITEM")) {
    CRules@ rules = getRules();
    if( @rules == null ) {
      error("ERROR: Getting The Rules Failed! ->'B.as'->'onCommand'");
      return;
    }
    CBitStream params;
    params.write_u16( _this_B.getNetworkID());
    params.write_u16( EQ_ITEM::TEST_GREEN );
    params.write_u16( EQ_STATE::WORLD );
    rules.SendCommand( EQ_CMD::MAKE_NEW, params );
  }
}



void onDie( CBlob@ _this ) {
  // Remove From Parent:
  CBlob@ parent = null;
  _this.get("parent", @parent );
  if( @parent != null ) {
    array<CBlob@>@ b_array = null;
    parent.get( "Bs", @b_array );
    if( @b_array != null ) {
      for( int i = 0 ; i < b_array.length() ; ++i ) {
	if( b_array[i].getNetworkID() == _this.getNetworkID()) {
	  b_array.removeAt( i );
	  break;
	}
      }//for
    }
  }    
}
