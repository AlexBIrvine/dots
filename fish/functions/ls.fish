function ls --wraps='exa -l --no-permissoins --no-user --no-time --icons -G -a' --wraps='exa -l --no-permissions --no-user --no-time --icons -G -a' --description 'alias ls exa -l --no-permissions --no-user --no-time --icons -G -a'
  exa -l --no-permissions --no-user --no-time --icons -G -a $argv
        
end
