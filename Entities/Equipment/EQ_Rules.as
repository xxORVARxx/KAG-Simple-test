/*
 *  list this file in 'gamemode.cfg'
 *
 */

#define SERVER_ONLY

#include "EQ4_Rules_functions.as"



void onInit( CRules@ _this ) {
  print("-------------------------------------------------------------------------------------------------------");
  _this.Tag("EQ");
  EQ::Manager equipment_manager;
  _this.set("EQM", @equipment_manager );
  _this.AddScript("EQ_Rules_register.as");
  // This Is Not A Good Init Functions, Becouse The 'gamemode.cfg' Havent Loaded The '.as' Files Yet. 
}



void onShowMenu( CRules@ _this ) {

}
 
void onSetPlayer( CRules@ _this, CBlob@ _blob, CPlayer@ _player ) {

}

void onPlayerChangedTeam( CRules@ _this, CPlayer@ _player, u8 _oldteam, u8 _newteam ) {

}

void onPlayerDie( CRules@ _this, CPlayer@ _victim, CPlayer@ _attacker, u8 _customData ) {

}

void onPlayerLeave( CRules@ _this, CPlayer@ _player ) {

}



void onCommand( CRules@ _this, u8 _cmd, CBitStream@ _params ) {
  EQ::Manager@ eqm = null;
  _this.get( "EQM", @eqm );
  if( eqm == null ) {
    error("EQ ERROR: Failed To Get The Equipment Manager! ->'EQ_Rules.as'->'onCommand'");
    return;
  }
  switch( _cmd ) {
  case EQ_CMD::MAKE_NEW:
    EQ::Make_new( eqm, _this, _params );
    break;
  case EQ_CMD::MOVE_TO_EQUIP:
    EQ::Move_to_equip( eqm, _this, _params );
    break;
  case EQ_CMD::MOVE_TO_STORAGE:
    EQ::Move_to_storage( eqm, _this, _params );
    break;
  case EQ_CMD::MOVE_TO_INVENTORY:
    EQ::Move_to_inventory( eqm, _this, _params );
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
  case EQ_CMD::REMOVE_FROM_INVENTORY:
    EQ::Remove_from_inventory( eqm, _this, _params );
    break;
  case EQ_CMD::REMOVE_FROM_WORLD:
    EQ::Remove_from_world( eqm, _this, _params );
    break;
  case EQ_CMD::KILL:
    EQ::Kill( eqm, _this, _params );
    break;
  }//switch
}
