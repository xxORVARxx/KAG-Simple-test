/*
 *  list this file in 'gamemode.cfg'
 *
 */

#define SERVER_ONLY

#include "EQ4_Rules_functions.as"



void onInit( CRules@ _this ) {
  print("-----------------------------------------------CRules-onInit-----------------------------------------------");
  _this.Tag("EQ");
  EQ::Manager equipment_manager;
  _this.set("EQM", @equipment_manager );
  // This Is Not A Good Init Functions To register the EQ-Items,
  // Becouse The 'gamemode.cfg' Havent Loaded The '.as' Files Yet.

  
  Vec2f pos1, pos2;
  CMap@ map = getMap();
  pos1.x = 10;
  pos2.x = map.tilemapwidth - 10;
  pos1.y = map.getLandHeightAtX( pos1.x );
  pos2.y = map.getLandHeightAtX( pos2.x );
  
  pos1.x *= map.tilesize;
  pos1.y *= map.tilesize;
  pos2.x *= map.tilesize;
  pos2.y *= map.tilesize;
  
  printVec2f("pos1: ", pos1 );
  printVec2f("pos2: ", pos2 ); 

  server_CreateBlob( "bucket", -1, pos1 );
  server_CreateBlob( "sponge", -1, pos2 );
  server_CreateBlob( "A", -1, pos1 );
  server_CreateBlob( "B", -1, pos2 );
}



void onNewPlayerJoin( CRules@ _this, CPlayer@ _player ) {
  if( ! _this.hasTag("EQ_REGISTERED")) {
    _this.Tag("EQ_REGISTERED");
    print("EQ: Register All Items:");
    for( uint i = 0 ; i < EQ_ITEM::g_str.length() ; ++i ) {
      CBlob@ item = server_CreateBlob( EQ_ITEM::g_str[i] );
      item.SendCommand( EQ_CMD::REGISTER );
    }//for
  }
  else
    print("EQ: Done Registering.");
}



void onRespawn( CRules@ _this, CRespawnQueueActor@ _queue, CPlayer@ _player, CBlob@ _blob ) {
 //Make 'B's for Players:
  Vec2f vel = getRandomVelocity( 90.0f, 2.0f, 120.0f );
  CBlob@ the_B = server_CreateBlob( "bucket", -1, _blob.getPosition());
  the_B.setVelocity( vel );
  printVec2f("MAKE B @: ", _blob.getPosition());
}


void onSetPlayer( CRules@ _this, CBlob@ _blob, CPlayer@ _player ) {
  printVec2f("Player pos: ", _blob.getPosition());
}

/*
void onShowMenu( CRules@ _this ) {
 // USEING THIS HOOK WILL BREAK MENU AND THE 'ESC' BOTTON!!!
}

void onSetPlayer( CRules@ _this, CBlob@ _blob, CPlayer@ _player ) {
 
}

void onPlayerChangedTeam( CRules@ _this, CPlayer@ _player, u8 _oldteam, u8 _newteam ) {

}

void onPlayerDie( CRules@ _this, CPlayer@ _victim, CPlayer@ _attacker, u8 _customData ) {

}

void onPlayerLeave( CRules@ _this, CPlayer@ _player ) {

}
*/


void onCommand( CRules@ _this, u8 _cmd, CBitStream@ _params ) {
  EQ::Manager@ eqm = null;
  _this.get( "EQM", @eqm );
  if( eqm == null ) {
    error("EQ ERROR: Failed To Get The Equipment Manager! ->'"+ getCurrentScriptName() +"'->'onCommand'");
    return;
  }
  switch( _cmd ) {  
  case EQ_CMD::MAKE_NEW_IN_EQUIP:
    EQ::Make_new_in_equip( eqm, _this, _params );
    break;
  case EQ_CMD::MAKE_NEW_IN_STORAGE:
    EQ::Make_new_in_storage( eqm, _this, _params );
    break;
  case EQ_CMD::MAKE_NEW_IN_WORLD:
    EQ::Make_new_in_world( eqm, _this, _params );
    break;
   
  case EQ_CMD::MOVE_TO_EQUIP:
    EQ::Move_to_equip( eqm, _this, _params );
    break;
  case EQ_CMD::MOVE_TO_STORAGE:
    EQ::Move_to_storage( eqm, _this, _params );
    break;
  case EQ_CMD::MOVE_TO_WORLD:
    EQ::Move_to_world( eqm, _this, _params );
    break;
    
  case EQ_CMD::REMOVE_FROM_EQUIP:
    EQ::Remove_from_equip( eqm, _this, _params );
    break;
  case EQ_CMD::REMOVE_FROM_STORAGE:
    EQ::Remove_from_storage( eqm, _this, _params );
    break;
  case EQ_CMD::REMOVE_FROM_WORLD:
    EQ::Remove_from_world( eqm, _this, _params );
    break;
    
  case EQ_CMD::KILL:
    EQ::Kill( eqm, _this, _params );
    break;
  }//switch
}
