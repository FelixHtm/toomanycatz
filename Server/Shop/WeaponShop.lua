-- Configure the shop locations
function initializeShop()
  for k,v in pairs(shopLocations) do
    v:on("BeginOverlap", function(actor)
      if actor:GetType() == "Character" then
        Events:CallRemote("EnterShop", actor:GetPlayer(), {v:GetValue("type")})
      end
    end)
    v:on("EndOverlap", function(actor)
      if actor:GetType() == "Character" then
        Events:CallRemote("LeaveShop", actor:GetPlayer(), {})
      end
    end)
  end
end


function handleBuy(player, option, idx)
  if option == "Pistol" then
    TmpzWeapons.PistolTier(player:GetControlledCharacter():GetLocation(), Rotator(), idx)
  elseif option == "Shotgun" then
    TmpzWeapons.ShotgunTier(player:GetControlledCharacter():GetLocation(), Rotator(), idx)
  elseif option == "Rifle" then
    TmpzWeapons.RifleTier(player:GetControlledCharacter():GetLocation(), Rotator(), idx)
  elseif option == "SMG" then
    TmpzWeapons.SMGTier(player:GetControlledCharacter():GetLocation(), Rotator(), idx)
  elseif option == "Catz" then
    TmpzWeapons.CatzTier(player:GetControlledCharacter():GetLocation(), Rotator(), idx)
  else
    Events:CallRemote("showMessage", player, {"Uuuh, how can I say that, something went wrong"})
    return 
  end
  Events:CallRemote("showMessage", player, {"Nice!"})
end


Events:on("Buy", function(player, option, idx)
  print(option .. " " .. idx)
  iPrice = prices[option][idx]
  pMoney = player:GetValue("bank")
  rMoney = pMoney - iPrice
  if rMoney >= 0 then
    player:SetValue("money", rMoney)
    handleBuy(player, option, idx)
    Events:CallRemote("Bought", player, {"Success"})
  else
    Events:CallRemote("Bought", player, {"Fail"})
  end
end)

initializeShop()

