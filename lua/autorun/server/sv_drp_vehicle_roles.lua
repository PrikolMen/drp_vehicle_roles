
do
    local vehs = {
        ["lfs_uh60"] = "Citizens",
        ["gred_simfphys_fennek_hmg"] = "Police",
        ["gred_simfphys_hummer"] = "Bandits"
    }

    local getCats = DarkRP.getCategories
    local IsValid = IsValid
    local ipairs = ipairs
    local type = type

    hook.Add("CanPlayerEnterVehicle", "DarkRP.Vehicle.Roles", function( ply, veh )
        local class = veh:GetClass()
        local parent = veh:GetParent()
        if IsValid( parent ) then
            if ( parent:GetClass() == "gmod_sent_vehicle_fphysics_base" ) then
                class = parent.VehicleName
            end

            if parent.LFS then
                class = parent:GetClass()
            end
        end

        local needCat = vehs[ class ]
        if (needCat == nil) then
            return
        end

        local plyTeam = ply:Team()
        local isTable = type( needCat ) == "table"

        for catNum, tbl in ipairs( getCats().jobs ) do
            if isTable then
                for needNum, cat in ipairs( needCat ) do
                    if (tbl.name == cat) then
                        for jobNum, job in ipairs( tbl.members ) do
                            if ( job.team == plyTeam ) then
                                return true
                            end
                        end
                    end
                end
            else
                if (tbl.name == needCat) then
                    for jobNum, job in ipairs( tbl.members ) do
                        if ( job.team == plyTeam ) then
                            return true
                        end
                    end
                end
            end
        end

        ply:PrintMessage( HUD_PRINTCENTER, "You can't seat on this vehicle." )

        return false
    end)
end