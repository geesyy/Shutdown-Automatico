-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookrr = "WEBHOOK AQUI"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-- Inicialização do código 

Citizen.CreateThread(function()
    Wait(43200000)
    vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(255,50,50,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 10%; right: 5%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>RR EM 5 MINUTOS!</bold><br><br>Mensagem enviada por: Sistema")
    SetTimeout(60000,function()
        vRPclient.removeDiv(-1,"anuncio")
    end)
    Wait(300000)
    local users = vRP.getUsers()
    for k,v in pairs(users) do
        local id = vRP.getUserSource(parseInt(k))
        if id then
            vRP.kick(id," Reinicialização concluida por timeout de 12 horas.\n Reinicie seu FiveM e entre novamente no server!")
        end
    end
    os.execute("start PowerShell.exe C:/Users/Administrator/Desktop/geesy/artifacts/FXServer.exe +exec server.cfg +set onesync_enableInfinity 1 +set onesync on +set sv_enforceGameBuild 2372 +set onesync_population true") -- Modifique para o seu diretório, caso contrário, não funcionará.
    SendWebhookMessage(webhookrr,"```prolog\n[Aviso]: Servidor reiniciado com sucesso após timeout de 12 horas!\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    Wait(1)
    os.exit()
end)

print(" [+] Script iniciado com sucesso!"..os.date("\n[Hora]: %H:%M:%S").."")

-- Código básico feito por mim, espero que ajudem vocês!!! Existem outras formas de se ter um shutdown automático (rr). Caso queira outras alternativas, procure usar o TxAdmin ou diversos.