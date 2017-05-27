


void onInit( CBlob@ _this ) {
  _this.Tag("is_A");

  _this.server_setTeamNum( -1 ); // Allow Anyone To Break Them.
  CShape@ shape = _this.getShape();
  if( shape != null ) {
    ShapeConsts@ consts = shape.getConsts();
    if( consts != null ) {
      consts.waterPasses = true;
    }
  }
  
  array<CBlob@> b_array;
  _this.set( "Bs", b_array );
   
  _this.addCommandID("list_children");
  _this.addCommandID("new_child");
  _this.addCommandID("kill_b");
  
  // void ::AddIconToken( const string&in _id, const string&in _PNG, Vec2f _frame_size, int _frame )
  AddIconToken( "$A$", "/../Mods/Simple_test/Entities/Common/Sprites/MyMiniIcons.png", Vec2f( 16.0f, 16.0f ), 0 );
  AddIconToken( "$B$", "/../Mods/Simple_test/Entities/Common/Sprites/MyMiniIcons.png", Vec2f( 16.0f, 16.0f ), 1 );
}



void onTick( CBlob@ _this ) {

}



void onSetStatic( CBlob@ _this, const bool _isStatic ) {
  if( ! _isStatic )
    return;
  _this.getSprite().PlaySound("/build_ladder.ogg");
  _this.getSprite().SetZ( -40 );
}



// When You Press 'E':
void GetButtonsFor( CBlob@ _this_A, CBlob@ _caller ) {
  if( _this_A.hasTag("is_A") && _this_A.isOverlapping( _caller )) {
    print("Hello From A");
    CBitStream params;
    // The Caller Is The Player.
    params.write_u16( _caller.getNetworkID()); // list_children -> param:1 && new_child -> param:1
    // Button 1:
    Vec2f buttonpos( -6, -6 );    
    CButton@ button1 = _caller.CreateGenericButton( "$A$", //<- Icon Token.
						    buttonpos, //<- Button Offset.
						    _this_A, //<- Button Attachment.
						    _this_A.getCommandID("list_children"), //<- Command ID.
						    "List Bs", //<- Description
						    params ); //<- Bit Stream.
    if( @button1 != null )
      button1.enableRadius = 32.0f;
    // Button 2:
    buttonpos.x += 12;
    CButton@ button2 = _caller.CreateGenericButton( "$B$",
						    buttonpos,
						    _this_A,
						    _this_A.getCommandID("new_child"),
						    "New B",
						    params );
    if( @button2 != null )
      button2.enableRadius = 32.0f;
  }
}



void List_all_children( CBlob@ _this, CBlob@ _caller ) {
  print("Lint All Children.");
  if(( @_this == null )||( @_caller == null ))
    return;
  array<CBlob@>@ b_array;
  if( ! _this.get( "Bs", @b_array ))
    return;
  Vec2f offset( 0.0f, -10.0f );
  Vec2f menu_size( 5.0f, 4.0f );
  CGridMenu@ menu = CreateGridMenu( _caller.getScreenPos() + offset,
				    _this,
				    menu_size,
				    "List Of Bs");
  if( @menu == null )
    return;
  menu.deleteAfterClick = true;
  // Add Buttons To The Menu:
  for( int i = 0 ; i < b_array.length ; ++i ) {
    CBitStream params;
    params.write_u16( b_array[i].getNetworkID()); // kill_b -> param:1
    params.write_u16( _caller.getNetworkID()); // kill_b -> param:2
    CGridButton@ button = menu.AddButton( "$B$",
					  b_array[i].getName(),
					  _this.getCommandID("kill_b"),
					  params );
    if( @button == null )
      continue;
    button.deleteAfterClick = true;
    button.selectOnClick = false;
    button.selectOneOnClick = false;
  }//for
}




bool Put_in_inventory( CBlob@ _caller, CBlob@ new_B ) {
  new_B.server_SetQuantity( 1 );
  return _caller.server_PutInInventory( new_B );
}
bool Put_in_hands( CBlob@ _caller, CBlob@ new_B ) {
  CBlob@ carrying = _caller.getCarriedBlob();
  if( @carrying == null ) {
    if( _caller.server_Pickup( new_B ))
      return true; // All Good.
  }
  // Failed To Hold, Try Putting It In Inventory:
  return Put_in_inventory( _caller, new_B );
}

void Make_new_child( CBlob@ _this, CBlob@ _caller ) {
  print("Make New Child.");
  if(( @_this == null )||( @_caller == null )||( ! _this.exists( "Bs" )))
    return;
  //CInventory@ inv = _caller.getInventory();
  //if( inv.isInInventory( "B", 1 ))
  //  return;
  CBlob@ new_B = server_CreateBlob( "B" );
  if( @new_B == null )
    return;
  if( Put_in_hands( _caller, new_B )) {
    new_B.set("parent", @_this );
    _this.push( "Bs", @new_B );
  }
  else
    new_B.server_Die();
}



void Kill_child( CBlob@ _this, u16 _id ) {
  print("Kill Child");
  array<CBlob@>@ b_array;
  if( _this.get( "Bs", @b_array )) {
    for( int i = 0 ; i < b_array.length ; ++i ) {
      if( _id == b_array[i].getNetworkID()) {
	b_array[i].server_Die();
	b_array.removeAt( i );
	break;
      }
    }//for
  }
}



void onCommand( CBlob@ _this_A, u8 _cmd, CBitStream@ _params ) {
  if( _cmd == _this_A.getCommandID("list_children")) {
    CBlob@ caller = getBlobByNetworkID( _params.read_u16()); // list_children -> param:1 || kill_b -> param:2
    List_all_children( _this_A, caller );
  }
  else if( _cmd == _this_A.getCommandID("new_child")) {
    CBlob@ caller = getBlobByNetworkID( _params.read_u16()); // new_child -> param:1
    Make_new_child( _this_A, caller );
  }
  else if( _cmd == _this_A.getCommandID("kill_b")) {
    u16 id = _params.read_u16(); // kill_b -> param:1
    Kill_child( _this_A, id );
    // We Have To Call It Again To Make The List Updata: (Remove The Killed B)
    _this_A.SendCommand( _this_A.getCommandID("list_children"), _params );
  }
}



bool canBePickedUp( CBlob@ _this, CBlob@ _by_blob ) {
  return false;
}



void onDie( CBlob@ _this ) {
  // Kill All Children:
  array<CBlob@>@ b_array;
  if( _this.get( "Bs", @b_array )) {
    for( int i = 0 ; i < b_array.length ; ++i ) {
      b_array[i].server_Die();
    }//for
  }
}
