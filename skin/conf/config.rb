$conf.breadcrumbs = [
 "<a href='https://github.com/ekassos/cs297r'>CS279R Github Repo Tracker</a>",
 "<a href='https://github.com/ekassos/doodle-representation'>Doodle Github Repo</a>"
]

$conf.default_css = "css/DoodleTheme.css"

# displays all available Polls in homepage
$conf.indexnotice = <<INDEXNOTICE
<h2>Available Polls</h2>
<table>
	<tr>
		<th>Poll ID</th><th>Last change</th>
	</tr>
INDEXNOTICE
Dir.glob("*/data.yaml").sort_by{|f|
	File.new(f).mtime
}.reverse.collect{|f| f.gsub(/\/data\.yaml$/,'') }.each{|site|
	$conf.indexnotice += <<INDEXNOTICE
<tr class='participantrow'>
	<td class='polls'><a href='./#{CGI.escape(site)}/'>#{CGI.escapeHTML(site)}</a></td>
	<td class='mtime'>#{File.new(site + "/data.yaml").mtime.strftime('%d.%m, %H:%M')}</td>
</tr>
INDEXNOTICE
}
$conf.indexnotice += "</table>"
