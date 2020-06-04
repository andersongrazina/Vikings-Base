resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

-- Example custom radios
supersede_radio "RADIO_06_COUNTRY" { url = "http://6d9a.webradio.upx.net.br:9049/stream", volume = 0.3}-- Sertanejo
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://6d9a.webradio.upx.net.br:9023/stream", volume = 0.3, } -- Hits
supersede_radio "RADIO_20_THELAB" { url = "http://6d9a.webradio.upx.net.br:9061/stream", volume = 0.3, } -- Pagode
supersede_radio "RADIO_17_FUNK" { url = "http://6d9a.webradio.upx.net.br:9065/stream", volume = 0.3, } -- Funk
supersede_radio "RADIO_18_90S_ROCK" { url = "http://6d9a.webradio.upx.net.br:9047/stream", volume = 0.3, } -- DJ
supersede_radio "RADIO_02_POP" { url = "http://6d9a.webradio.upx.net.br:9051/stream", volume = 0.3, } -- Novidade
supersede_radio "RADIO_07_DANCE_01" { url = "http://6d9a.webradio.upx.net.br:9070/stream", volume = 0.3, } -- Festa
supersede_radio "RADIO_08_MEXICAN" { url = "http://6d9a.webradio.upx.net.br:9940/stream", volume = 0.3, } -- 00's

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}
