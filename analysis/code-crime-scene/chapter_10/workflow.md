`maat -l maat_evo.log -c git -a coupling -g maat_pipes_filter_boundaries.txt`

`git clone https://github.com/nopSolutions/nopCommerce`
`git log --pretty=format:'[%h] %an %ad %s' --date=short --numstat \
--after 2014-01-01 --before 2014-09-25 > nop_evo_2014.log`
`maat -c git -l nop_evo_2014.log -g arch_boundaries.txt -a coupling`
`maat -c git -l nop_evo_2014.log -g arch_boundaries.txt -a revisions`
