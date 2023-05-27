function up --wraps='sudo xbps-install -Su' --description 'alias up sudo xbps-install -Su'
  sudo xbps-install -Su $argv
        
end
