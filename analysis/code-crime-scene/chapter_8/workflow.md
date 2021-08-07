## Sum of coupling

```
maat -l maat_evo.log -c git -a soc
maat -l maat_evo.log -c git -a coupling

```

## Minecraft

```
git clone https://github.com/SirCmpwn/Craft.Net.git

git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--before=2014-08-08 > craft_evo_complete.log

maat -l craft_evo_complete.log -c git -a soc

## initial period:

```
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--before=2013-01-01 > craft_evo_130101.log

maat -l craft_evo_130101.log -c git -a coupling > craft_coupling_130101.csv
```

```
git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--after=2013-01-01 --before=2014-08-08 > craft_evo_140808.log

maat -l craft_evo_140808.log -c git -a coupling > craft_coupling_140808.csv
```
