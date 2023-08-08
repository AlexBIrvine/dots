function un --wraps='sudo xbps-remove ' --wraps='sudo xbps-remove -R ' --description 'alias un sudo xbps-remove -R '
  sudo xbps-remove -R  $argv
        
end
