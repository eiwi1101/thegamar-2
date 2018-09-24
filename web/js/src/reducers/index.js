import { combineReducers } from "redux"
import commands from "./commands"

const game = combineReducers({
  commands
});

export default game
