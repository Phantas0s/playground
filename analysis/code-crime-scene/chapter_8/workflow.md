## Sum of coupling

maat -l maat_evo.log -c git -a soc
maat -l maat_evo.log -c git -a coupling

git clone https://github.com/SirCmpwn/Craft.Net.git

git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--before=2014-08-08 > craft_evo_complete.log

maat -l craft_evo_complete.log -c git -a soc
