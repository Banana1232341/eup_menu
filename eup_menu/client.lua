local eupMenu = {
    opened = false,
    title = "EUP Menu",
    currentItemIndex = 1,
    items = {
        {name = "Police Uniform", texture = "police1"},
        {name = "Firefighter Uniform", texture = "firefighter1"},
        {name = "EMS Uniform", texture = "ems1"},
    }
}

function drawTxt(x, y, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(false)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function openEupMenu()
    eupMenu.opened = true
end

function closeEupMenu()
    eupMenu.opened = false
end

function selectEupItem(index)
    local selectedItem = eupMenu.items[index]
    -- Code to change player outfit
    -- For example: SetPedComponentVariation(playerPed, componentId, drawableId, textureId, paletteId)
    -- This needs to be customized based on your EUP setup
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if eupMenu.opened then
            local x = 0.85 -- Position from the left
            local y = 0.05 -- Position from the top
            local spacing = 0.03

            drawTxt(x, y, 0.7, eupMenu.title, 255, 255, 255, 255, true)
            for i, item in ipairs(eupMenu.items) do
                local color = {r = 255, g = 255, b = 255, a = 255}
                if i == eupMenu.currentItemIndex then
                    color = {r = 0, g = 255, b = 0, a = 255} -- Highlight selected item
                end
                drawTxt(x, y + (i * spacing), 0.5, item.name, color.r, color.g, color.b, color.a, true)
            end

            if IsControlJustPressed(1, 38) then -- E key to open/close menu
                closeEupMenu()
            elseif IsControlJustPressed(1, 172) then -- Up arrow
                eupMenu.currentItemIndex = eupMenu.currentItemIndex - 1
                if eupMenu.currentItemIndex < 1 then
                    eupMenu.currentItemIndex = #eupMenu.items
                end
            elseif IsControlJustPressed(1, 173) then -- Down arrow
                eupMenu.currentItemIndex = eupMenu.currentItemIndex + 1
                if eupMenu.currentItemIndex > #eupMenu.items then
                    eupMenu.currentItemIndex = 1
                end
            elseif IsControlJustPressed(1, 201) then -- Enter key
                selectEupItem(eupMenu.currentItemIndex)
            end
        elseif IsControlJustPressed(1, 38) then -- E key to open/close menu
            openEupMenu()
        end
    end
end)
