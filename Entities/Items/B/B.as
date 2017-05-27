


void onInit( CBlob@ _this ) {
  _this.Tag("B");
   
  CBlob@ parent = null;
  _this.set("parent", @parent );
  
  _this.addCommandID("kill");
}



void onTick( CBlob@ _this ) {

}



void GetButtonsFor( CBlob@ _this, CBlob@ _caller ) {
  if( _this.hasTag("B") && _this.isOverlapping( _caller )) {
    print("Hello From B");
    CButton@ button = _caller.CreateGenericButton( "$B$", //<- Icon Token.
						   Vec2f( 0.0f, -6.0f ), //<- Button Offset.
						   _this, //<- Button Attachment.
						   _this.getCommandID("kill"), //<- Command ID.
						   "Kill"); //<- Description
    if( @button != null )
      button.enableRadius = 16.0f;
  }
}



void onCommand( CBlob@ _this_B, u8 _cmd, CBitStream@ _params ) {
  if( _cmd == _this_B.getCommandID("kill")) {
    _this_B.server_Die();
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
