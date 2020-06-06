Class=require 'lib/class'
push=require 'lib/push'

require 'src/constants'
require 'src/Util'

require 'src/paddle'
require 'src/Ball'
require 'src/Bricks'
require 'src/LevelMaker'
require 'src/Power'
require 'src/StateMachine'

--loading all states
require 'src/states/BaseClass'
require 'src/states/TitleState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/VictoryState'
require 'src/states/GameOverState'
require 'src/states/PaddleSelectState'
require 'src/states/HighScoreState'
require 'src/states/EnterHighScoreState'