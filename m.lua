-- ts file was generated at t.me/BIood_AngeI


game:GetService("Players").LocalPlayer.Idled:Connect(function()
    local v1 = game:GetService("VirtualUser")
    v1:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    v1:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
-- Временно отключена проверка PlaceId для тестирования
-- if game.PlaceId == 72829404259339 then
    print("Script loaded - PotuzhniyChit v1.0")
    print("Delta Executor support enabled")

    -- Проверяем доступные функции executor'а
    local executorInfo = {
        ["getcustomasset"] = getcustomasset and "available" or "not available",
        ["writefile"] = writefile and "available" or "not available",
        ["readfile"] = readfile and "available" or "not available",
        ["isfile"] = isfile and "available" or "not available",
        ["isfolder"] = isfolder and "available" or "not available",
        ["makefolder"] = makefolder and "available" or "not available",
        ["request"] = request and "available" or "syn_request available" or "not available"
    }

    print("Executor functions check:")
    for func, status in pairs(executorInfo) do
        print("  " .. func .. ": " .. status)
    end
    local v2 = getgenv()
    local v3 = getgenv()
    local v4 = getgenv()
    local v5 = getgenv()
    getgenv().WantedStatForRoll = {}
    v5.WantedUnitForEvo = {}
    v4.WantedItemsForChallenge = {}
    v3.WantedRangers = {}
    v2.WantedNotify = {}
    local v6 = Instance.new("ScreenGui")
    v6.Name = (function(p7)
        local v8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        local v9 = ""
        for _ = 1, p7 do
            local v10 = math.random(1, # v8)
            v9 = v9 .. v8:sub(v10, v10)
        end
        return v9
    end)(12)
    v6.ResetOnSpawn = false
    v6.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local v11 = Instance.new("TextButton")
    v11.Size = UDim2.new(0, 100, 0, 40)
    v11.Position = UDim2.new(0.9, 0, 0.1, 0)
    v11.Text = "Open/Close"
    v11.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
    v11.TextColor3 = Color3.new(1, 1, 1)
    v11.Font = Enum.Font.SourceSansBold
    v11.TextSize = 18
    v11.Active = true
    v11.Draggable = true
    v11.Parent = v6
    v11.MouseButton1Click:Connect(function()
        local v12 = game:GetService("VirtualInputManager")
        v12:SendKeyEvent(true, "LeftControl", false, game)
        v12:SendKeyEvent(false, "LeftControl", false, game)
    end)
    local function vu21(p13, p14, p15)
        if p13 and p13:IsA("GuiObject") then
            local v16 = game:GetService("GuiService"):GetGuiInset()
            local v17 = p13.AbsolutePosition + v16 + p13.AbsoluteSize / 2
            local v18 = v17.X + (p14 or 0)
            local v19 = v17.Y + (p15 or 0)
            local v20 = game:GetService("VirtualInputManager")
            v20:SendMouseButtonEvent(v18, v19, 0, true, game, 0)
            task.wait()
            v20:SendMouseButtonEvent(v18, v19, 0, false, game, 0)
        end
    end
    local function vu24(pu22, pu23)
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("PlayRoom"):WaitForChild("Event"):FireServer(pu22, pu23)
        end)
        task.wait(0.5)
    end
    getgenv().FoundPortal = "Waiting"
    -- Используем локальную версию MacLib с поддержкой кастомного фона
    local v25
    if isfile and isfile("maclib.txt") and readfile then
        v25 = loadstring(readfile("maclib.txt"))()
        print("Loaded local MacLib with custom background support")
    else
        v25 = loadstring(game:HttpGet("https://lolikon.su/vo/maclib.txt"))()
        print("Loaded remote MacLib (local version not found)")
    end
    local vu26 = v25:Window({
        Title = "ПОТУЖНИЙ ЧIТ",
        Subtitle = "t.me/BIood_AngeI",
        Size = UDim2.fromOffset(800, 650),
        DragStyle = 2,
        DisabledWindowControls = {},
        ShowUserInfo = false,
        Keybind = Enum.KeyCode.LeftControl,
        AcrylicBlur = false,
        CustomBackground = getcustomasset and isfile and isfile("custom_bg.png") and getcustomasset("custom_bg.png") or nil
    })
    
    -- Добавляем фоновое изображение на фон меню (исправленная версия)
    task.spawn(function()
        -- Ждем дольше для полной загрузки GUI
        task.wait(1.0)

        -- Функция для поиска главного Frame
        local function findMainFrame(gui)
            -- Проверяем, является ли сам объект Frame
            if gui:IsA("Frame") then
                return gui
            end

            -- Ищем Frame среди дочерних элементов
            for _, child in pairs(gui:GetChildren()) do
                if child:IsA("Frame") and child.Name ~= "BackgroundImage" then
                    -- Проверяем размер - главный Frame обычно большой
                    if child.Size.X.Scale >= 0.8 and child.Size.Y.Scale >= 0.8 then
                        print("Найден главный Frame по размеру: " .. child.Name)
                        return child
                    end
                end
            end

            -- Ищем Frame рекурсивно
            for _, descendant in pairs(gui:GetDescendants()) do
                if descendant:IsA("Frame") and descendant.Name ~= "BackgroundImage" then
                    if descendant.Size.X.Scale >= 0.8 and descendant.Size.Y.Scale >= 0.8 then
                        print("Найден главный Frame рекурсивно: " .. descendant:GetFullName())
                        return descendant
                    end
                end
            end

            -- Fallback - возвращаем первый большой Frame
            for _, child in pairs(gui:GetChildren()) do
                if child:IsA("Frame") and child.Size.X.Offset >= 700 then
                    print("Fallback Frame найден: " .. child.Name)
                    return child
                end
            end

            print("Главный Frame не найден!")
            return nil
        end

        local mainFrame = findMainFrame(vu26)
        if not mainFrame then
            print("❌ Невозможно добавить фон - Frame не найден")
            return
        end

        -- Удаляем существующий фон если есть
        local existingBg = mainFrame:FindFirstChild("BackgroundImage")
        if existingBg then
            existingBg:Destroy()
            print("Удален существующий фон")
        end

        -- Определяем источник изображения
        local imageAsset = nil

        -- 1. Сначала пробуем custom_bg.png в корне
        if getcustomasset and isfile and isfile("custom_bg.png") then
            imageAsset = getcustomasset("custom_bg.png")
            print("✓ Используем custom_bg.png из корня")
        else
            print("custom_bg.png не найден в корне")
        end

        -- 2. Если не нашли, пробуем скачать из интернета
        if not imageAsset and request and writefile and isfile and getcustomasset then
            local imageUrl = "https://lolikon.su/static/media/rhack/bg.png"
            local imagePath = "PotuzhniyChit/bg.png"

            -- Создаем папку если нужно
            if makefolder and not isfolder("PotuzhniyChit") then
                makefolder("PotuzhniyChit")
                print("✓ Создана папка PotuzhniyChit")
            end

            -- Скачиваем если файл не существует
            if not isfile(imagePath) then
                print("Скачиваем изображение фона...")
                local success, result = pcall(function()
                    local response = request({
                        Url = imageUrl,
                        Method = "GET",
                        Headers = {
                            ["User-Agent"] = "Roblox/WinInet"
                        }
                    })

                    if response and response.StatusCode == 200 and response.Body then
                        writefile(imagePath, response.Body)
                        print("✓ Изображение скачано: " .. imagePath)
                        return true
                    else
                        print("❌ Ошибка скачивания: " .. tostring(response and response.StatusCode or "Unknown"))
                        return false
                    end
                end)

                if not success then
                    print("❌ Ошибка при скачивании: " .. tostring(result))
                end
            end

            -- Загружаем через getcustomasset
            if isfile(imagePath) then
                imageAsset = getcustomasset(imagePath)
                print("✓ Изображение загружено из файла: " .. imagePath)
            end
        end

        -- 3. Fallback на прямую ссылку
        if not imageAsset then
            imageAsset = "https://lolikon.su/static/media/rhack/bg.png"
            print("Используем прямую ссылку на изображение")
        end

        -- Создаем ImageLabel для фона
        local bgImage = Instance.new("ImageLabel")
        bgImage.Name = "BackgroundImage"
        bgImage.Image = imageAsset
        bgImage.Size = UDim2.new(1, 0, 1, 0)
        bgImage.Position = UDim2.new(0, 0, 0, 0)
        bgImage.BackgroundTransparency = 1
        bgImage.ZIndex = 0
        bgImage.BorderSizePixel = 0
        bgImage.ScaleType = Enum.ScaleType.Crop
        bgImage.Parent = mainFrame

        print("✓ Фоновое изображение добавлено: " .. bgImage:GetFullName())

        -- Перемещаем все остальные элементы поверх фона
        local movedCount = 0
        for _, child in pairs(mainFrame:GetChildren()) do
            if child ~= bgImage and child:IsA("GuiObject") then
                if child.ZIndex <= 0 then
                    child.ZIndex = 1
                    movedCount = movedCount + 1
                end
            end
        end

        print("✓ Перемещено элементов поверх фона: " .. movedCount)
        print("✅ Фон успешно установлен!")
    end)
    
    local v27 = {}
    local v28 = vu26
    local v29 = vu26.GlobalSetting
    local v30 = {
        Name = "UI Blur"
    }
    local v31 = vu26
    v30.Default = vu26.GetAcrylicBlurState(v31)
    function v30.Callback(p32)
        vu26:SetAcrylicBlurState(false)
        vu26:Notify({
            Title = vu26.Settings.Title,
            Description = (p32 and "Enabled" or "Disabled") .. " UI Blur",
            Lifetime = 5
        })
    end
    v27.UIBlurToggle = v29(v28, v30)
    local v33 = vu26
    local v34 = vu26.GlobalSetting
    local v35 = {
        Name = "Notifications"
    }
    local v36 = vu26
    v35.Default = vu26.GetNotificationsState(v36)
    function v35.Callback(p37)
        vu26:SetNotificationsState(p37)
        vu26:Notify({
            Title = vu26.Settings.Title,
            Description = (p37 and "Enabled" or "Disabled") .. " Notifications",
            Lifetime = 5
        })
    end
    v27.NotificationToggler = v34(v33, v35)
    local v38 = vu26
    local v39 = vu26.GlobalSetting
    local v40 = {
        Name = "Show User Info"
    }
    local v41 = vu26
    v40.Default = vu26.GetUserInfoState(v41)
    function v40.Callback(p42)
        vu26:SetUserInfoState(false)
        vu26:Notify({
            Title = vu26.Settings.Title,
            Description = (p42 and "Showing" or "Redacted") .. " User Info",
            Lifetime = 5
        })
    end
    v27.ShowUserInfo = v39(v38, v40)
    local v43 = vu26
    local v44 = {
        Title = "ПОТУЖНИЙ ЧIТ",
        Description = "Are You Mobile or PC?",
        Buttons = {
            {
                Name = "Mobile",
                Callback = function()
                    vu26:SetScale(0.65)
                end
            },
            {
                Name = "PC",
                Callback = function()
                    vu26:SetScale(1)
                end
            }
        }
    }
    vu26.Dialog(v43, v44)
    local v45 = {}
    local v46 = vu26
    v45.TabGroup1 = vu26.TabGroup(v46)
    local v47 = {
        Main = v45.TabGroup1:Tab({
            Name = "Main"
        }),
        Info = v45.TabGroup1:Tab({
            Name = "Info"
        }),
        Upgrade = v45.TabGroup1:Tab({
            Name = "Place & Upgrade"
        }),
        Evo = v45.TabGroup1:Tab({
            Name = "Misc"
        }),
        Misc = v45.TabGroup1:Tab({
            Name = "Challenge & Rangers"
        }),
        Settings = v45.TabGroup1:Tab({
            Name = "Settings"
        })
    }
    local vu48 = {
        MainSection1 = v47.Main:Section({
            Side = "Left"
        }),
        MainSection2 = v47.Main:Section({
            Side = "Right"
        }),
        MainSection3 = v47.Main:Section({
            Side = "Left"
        }),
        MainSection4 = v47.Info:Section({
            Side = "Left"
        }),
        MainSection5 = v47.Info:Section({
            Side = "Right"
        }),
        MainSection6 = v47.Info:Section({
            Side = "Left"
        }),
        MainSection8 = v47.Upgrade:Section({
            Side = "Right"
        }),
        MainSection10 = v47.Upgrade:Section({
            Side = "Right"
        }),
        MainSection14 = v47.Upgrade:Section({
            Side = "Left"
        }),
        MainSection19 = v47.Evo:Section({
            Side = "Left"
        }),
        MainSection20 = v47.Evo:Section({
            Side = "Right"
        }),
        MainSection22 = v47.Evo:Section({
            Side = "Right"
        }),
        MainSection25 = v47.Evo:Section({
            Side = "Left"
        }),
        MainSection11 = v47.Misc:Section({
            Side = "Left"
        }),
        MainSection16 = v47.Misc:Section({
            Side = "Left"
        }),
        MainSection18 = v47.Misc:Section({
            Side = "Right"
        }),
        MainSection17 = v47.Misc:Section({
            Side = "Right"
        }),
        MainSection7 = v47.Misc:Section({
            Side = "Right"
        }),
        MainSection12 = v47.Settings:Section({
            Side = "Right"
        }),
        MainSection13 = v47.Settings:Section({
            Side = "Right"
        })
    }
    vu48.MainSection1:Header({
        Name = "AutoJoin-Type World For All Modes:"
    })
    local vu50 = vu48.MainSection1:Dropdown({
        Name = "Select Type To Auto Join:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Story",
            "Ranger",
            "Raid",
            "Challenge",
            "Infinity Castle",
            "Portal",
            "AFK Chamber"
        },
        Default = "",
        Callback = function(p49)
            getgenv().TypePortal = p49
        end
    }, "PortalSelect")
    vu48.MainSection2:Header({
        Name = "Story Configs:"
    })
    local vu51 = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server")
    local v52 = vu51
    local vu53 = vu51.WaitForChild(v52, "PlayRoom"):WaitForChild("Event")
    local vu54 = game:GetService("Players").LocalPlayer.PlayerGui
    vu48.MainSection2:Dropdown({
        Name = "World:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "OnePiece",
            "Namek",
            "DemonSlayer",
            "Naruto",
            "OPM",
            "TokyoGhoul"
        },
        Default = "",
        Callback = function(p55)
            getgenv().WorldSelect = p55
        end
    }, "SelectWorldStory")
    vu48.MainSection2:Dropdown({
        Name = "Act:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10"
        },
        Default = "",
        Callback = function(p56)
            getgenv().ActSelect = p56
        end
    }, "SelectActStory")
    vu48.MainSection2:Dropdown({
        Name = "Difficulty:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Normal",
            "Hard",
            "Nightmare"
        },
        Default = "",
        Callback = function(p57)
            getgenv().DifficultySelect = p57
        end
    }, "SelectDifficultySelect")
    vu48.MainSection2:Header({
        Name = "Ranger Configs:"
    })
    vu48.MainSection2:Dropdown({
        Name = "World:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "OnePiece",
            "Namek",
            "DemonSlayer",
            "Naruto",
            "OPM",
            "TokyoGhoul"
        },
        Default = "",
        Callback = function(p58)
            getgenv().WorldSelectRanger = p58
        end
    }, "SelectWorldStoryRanger")
    vu48.MainSection2:Dropdown({
        Name = "Act:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "1",
            "2",
            "3",
            "4",
            "5"
        },
        Default = "",
        Callback = function(p59)
            getgenv().ActSelectRanger = p59
        end
    }, "SelectActRanger")
    local vu68 = vu48.MainSection1:Toggle({
        Name = "Create Config Type World",
        Default = false,
        Callback = function(p60)
            getgenv().CreatePortal = p60
            if p60 then
                if not game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") then
                    task.spawn(function()
                        while true do
                            if not getgenv().CreatePortal then
                                return
                            end
                            if getgenv().TypePortal ~= "Story" then
                                if getgenv().TypePortal ~= "Ranger" then
                                    if getgenv().TypePortal == "Raid" or getgenv().TypePortal == "Infinity Castle" then
                                        return
                                    end
                                    if getgenv().TypePortal ~= "AFK Chamber" then
                                        if getgenv().TypePortal ~= "Portal" then
                                            if getgenv().TypePortal == "Challenge" then
                                                vu53:FireServer("Create", {
                                                    CreateChallengeRoom = true
                                                })
                                                task.wait(0.3)
                                                vu53:FireServer("Start")
                                                break
                                            end
                                        else
                                            local v61 = game:GetService("Players").LocalPlayer.PlayerGui.Items.Main.Base.Space.Scrolling
                                            local v62, v63, v64 = pairs(v61:GetChildren())
                                            local v65 = nil
                                            while true do
                                                local v66
                                                v64, v66 = v62(v63, v64)
                                                if v64 == nil then
                                                    v66 = v65
                                                    break
                                                end
                                                if string.find(v66.Name, "Ghoul City Portal") then
                                                    break
                                                end
                                            end
                                            if v66 then
                                                print("\239\191\189\239\191\189 Found Portal:", v66.Name)
                                                getgenv().FoundPortal = "True"
                                                if game:GetService("Players").LocalPlayer.PlayerGui.HUD.PortalFrame.Visible == false then
                                                    local v67 = {
                                                        game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].Items[v66.Name]
                                                    }
                                                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Lobby"):WaitForChild("ItemUse"):FireServer(unpack(v67))
                                                end
                                                task.wait(0.5)
                                                game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Lobby"):WaitForChild("PortalEvent"):FireServer(unpack({
                                                    "Start"
                                                }))
                                                break
                                            end
                                            print("\239\191\189\239\191\189 Not found portal")
                                            getgenv().FoundPortal = "False"
                                        end
                                    elseif not game:GetService("Players").LocalPlayer.PlayerGui.AFKChamber.Enabled then
                                        vu51:WaitForChild("Lobby"):WaitForChild("AFKWorldTeleport"):FireServer()
                                        break
                                    end
                                elseif not vu54.PlayRoom.Main.GameStage.Visible then
                                    vu53:FireServer("Create")
                                    task.wait(0.3)
                                    vu53:FireServer("Change-Mode", {
                                        Mode = "Ranger Stage"
                                    })
                                    task.wait(0.3)
                                    vu53:FireServer("Change-World", {
                                        World = getgenv().WorldSelectRanger
                                    })
                                    task.wait(0.3)
                                    vu53:FireServer("Change-Chapter", {
                                        Chapter = getgenv().WorldSelectRanger .. "_RangerStage" .. getgenv().ActSelectRanger
                                    })
                                    task.wait(0.3)
                                    vu53:FireServer("Submit")
                                    task.wait(0.3)
                                    vu53:FireServer("Start")
                                    break
                                end
                            elseif not vu54.PlayRoom.Main.GameStage.Visible then
                                vu53:FireServer("Create")
                                task.wait(0.5)
                                vu53:FireServer("Change-World", {
                                    World = getgenv().WorldSelect
                                })
                                task.wait(0.5)
                                vu53:FireServer("Change-Chapter", {
                                    Chapter = getgenv().WorldSelect .. "_Chapter" .. tostring(getgenv().ActSelect)
                                })
                                task.wait(1.5)
                                vu53:FireServer("Change-Difficulty", {
                                    Difficulty = getgenv().DifficultySelect
                                })
                                task.wait(0.5)
                                vu53:FireServer("Submit")
                                task.wait(0.3)
                                vu53:FireServer("Start")
                                break
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            else
                return
            end
        end
    }, "CreatePortal")
    vu48.MainSection3:Header({
        Name = "In-Match Configs:"
    })
    vu48.MainSection3:Toggle({
        Name = "Auto Vote Start",
        Default = false,
        Callback = function(p69)
            getgenv().AutoVoteStart = p69
            if p69 then
                task.spawn(function()
                    while getgenv().AutoVoteStart do
                        if vu54.HUD.InGame.VotePlaying.Visible then
                            vu51:WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VotePlaying"):FireServer()
                        end
                        task.wait(0.5)
                        if not getgenv().AutoVoteStart then
                            break
                        end
                    end
                end)
            end
        end
    }, "AutoVoteStartToggle")
    vu48.MainSection3:Toggle({
        Name = "Auto Play",
        Default = false,
        Callback = function(p70)
            getgenv().AutoSelectCard = p70
            if p70 then
                task.spawn(function()
                    while getgenv().AutoSelectCard do
                        if game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].Data.AutoPlay.Value == false then
                            vu51:WaitForChild("Units"):WaitForChild("AutoPlay"):FireServer()
                        end
                        task.wait(0.5)
                        if not getgenv().AutoSelectCard then
                            break
                        end
                    end
                end)
            elseif game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].Data.AutoPlay.Value == true then
                vu51:WaitForChild("Units"):WaitForChild("AutoPlay"):FireServer()
            end
        end
    }, "AutoPlayToggle")
    vu48.MainSection3:Toggle({
        Name = "Auto UP Maximum Yen [In-Match]",
        Default = false,
        Callback = function(p71)
            getgenv().AutoUpgradeYen = p71
            if p71 then
                vu26:Dialog({
                    Title = "ПОТУЖНИЙ ЧIТ notify",
                    Description = "this upgrade is for in-match not in lobby. Which mean u need max Yen to upgrade it.",
                    Buttons = {
                        {
                            Name = "Bet daddy kazoun~",
                            Callback = function()
                            end
                        }
                    }
                })
            end
            if p71 then
                task.spawn(function()
                    while getgenv().AutoUpgradeYen do
                        vu51:WaitForChild("Gameplay"):WaitForChild("StatsManager"):FireServer("MaximumYen")
                        task.wait(0.5)
                        if not getgenv().AutoUpgradeYen then
                            break
                        end
                    end
                end)
            end
        end
    }, "AutoUpgradeYenToggle")
    vu48.MainSection3:Toggle({
        Name = "Auto Remove Enemies [Visual]",
        Default = false,
        Callback = function(p72)
            getgenv().RemoveEnemies = p72
            if p72 then
                task.spawn(function()
                    local v73 = workspace.Agent.EnemyT
                    while getgenv().RemoveEnemies do
                        local v74, v75, v76 = ipairs(v73:GetChildren())
                        while true do
                            local v77
                            v76, v77 = v74(v75, v76)
                            if v76 == nil then
                                break
                            end
                            if v77:IsA("Part") then
                                v77:Destroy()
                            end
                        end
                        task.wait(0.5)
                        if not getgenv().RemoveEnemies then
                            break
                        end
                    end
                end)
            end
        end
    }, "AutoRemoveEnemiesToggle")
    vu48.MainSection3:Input({
        Name = "Enter Distance To Auto Ult:",
        Placeholder = "Input",
        AcceptedCharacters = "All",
        Callback = function(p78)
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully set distance for auto ult to " .. p78
            })
        end,
        onChanged = function(p79)
            getgenv().NumberUlt = tonumber(p79) or 20
        end
    }, "DistanceUlt")
    vu48.MainSection3:Toggle({
        Name = "Auto Ultimate If Enemies Near",
        Default = false,
        Callback = function(p80)
            getgenv().AutoUlt = p80
            if p80 then
                vu26:Dialog({
                    Title = "ПОТУЖНИЙ ЧIТ notify",
                    Description = "if you turn on auto-remove enemies then this feature wont working.",
                    Buttons = {
                        {
                            Name = "Bet daddy kazoun~",
                            Callback = function()
                            end
                        }
                    }
                })
            end
            if p80 then
                task.spawn(function()
                    local v81 = workspace.Agent.UnitT
                    local v82 = workspace.Agent.EnemyT
                    local v83 = vu51:WaitForChild("Units"):WaitForChild("Ultimate")
                    while getgenv().AutoUlt do
                        local v84, v85, v86 = ipairs(v81:GetChildren())
                        while true do
                            local v87
                            v86, v87 = v84(v85, v86)
                            if v86 == nil then
                                break
                            end
                            if v87:IsA("Part") and (v87:FindFirstChild("Info") and v87.Info.ActiveAbility.Value ~= "") then
                                local v88 = tonumber(getgenv().NumberUlt) or 20
                                local v89, v90, v91 = ipairs(v82:GetChildren())
                                local v92 = nil
                                while true do
                                    local v93
                                    v91, v93 = v89(v90, v91)
                                    if v91 == nil then
                                        break
                                    end
                                    if v93:IsA("Part") then
                                        local v94 = (v87.Position - v93.Position).Magnitude
                                        if v94 < v88 then
                                            v92 = v93
                                            v88 = v94
                                        end
                                    end
                                end
                                if v92 then
                                    v83:FireServer(v81[v87.Name])
                                end
                            end
                        end
                        task.wait(0.5)
                        if not getgenv().AutoUlt then
                            break
                        end
                    end
                end)
            end
        end
    }, "AutoUltToggle")
    local vu96 = vu48.MainSection3:Dropdown({
        Name = "Select Action After: ",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Retry",
            "Next Stage",
            "Return To Lobby"
        },
        Default = "None",
        Callback = function(p95)
            getgenv().Method = p95
        end
    }, "Method")
    vu48.MainSection4:Header({
        Name = "Player Info:"
    })
    local v97 = game.Players.LocalPlayer
    local v98 = game:GetService("ReplicatedStorage").Player_Data[v97.Name].Data
    local v99, v100, v101 = ipairs({
        "Gem",
        "Gold",
        "Exp",
        "CurseToken",
        "MaxCollection",
        "Title"
    })
    local vu102 = {}
    local v103 = {}
    while true do
        local v104, vu105 = v99(v100, v101)
        if v104 == nil then
            break
        end
        v101 = v104
        local vu106 = v98:FindFirstChild(vu105)
        if vu106 and vu106:IsA("ValueBase") then
            vu102[vu105] = vu106.Value
            local vu107 = vu48.MainSection4:Label({
                Text = vu105 .. ": " .. tostring(vu106.Value)
            })
            v103[vu105] = vu107
            vu106:GetPropertyChangedSignal("Value"):Connect(function()
                local v108 = vu106.Value
                local v109 = vu102[vu105]
                local v110 = vu105 .. ": " .. tostring(v108)
                if typeof(v108) ~= "number" or typeof(v109) ~= "number" then
                    if typeof(v108) == "string" and v108 ~= v109 then
                        v110 = v110 .. " (changed from: " .. tostring(v109) .. ")"
                    end
                else
                    local v111 = v108 - v109
                    if v111 ~= 0 then
                        v110 = v110 .. " (+" .. tostring(v111) .. " last match)"
                    end
                end
                vu107:UpdateName(v110)
                vu102[vu105] = v108
            end)
        end
    end
    vu48.MainSection5:Header({
        Name = "Player Inventory Info:"
    })
    local v112 = game.Players.LocalPlayer
    local v113 = game:GetService("ReplicatedStorage").Player_Data[v112.Name].Items
    local v114, v115, v116 = ipairs(v113:GetChildren())
    local vu117 = {}
    local vu118 = {}
    while true do
        local v119, vu120 = v114(v115, v116)
        if v119 == nil then
            break
        end
        v116 = v119
        if vu120:IsA("Folder") and vu120:FindFirstChild("Amount") then
            vu117[vu120.Name] = vu120.Amount.Value
            local v121 = vu48.MainSection5:Label({
                Text = vu120.Name .. ": " .. tostring(vu120.Amount.Value)
            })
            vu118[vu120.Name] = v121
            vu120.Amount:GetPropertyChangedSignal("Value"):Connect(function()
                local v122 = vu120.Amount.Value
                local v123 = v122 - vu117[vu120.Name]
                local v124 = vu120.Name .. ": " .. tostring(v122)
                if v123 ~= 0 then
                    v124 = v124 .. " (+ " .. tostring(v123) .. " last match)"
                end
                vu118[vu120.Name]:UpdateName(v124)
                vu117[vu120.Name] = v122
            end)
        end
    end
    vu48.MainSection6:Header({
        Name = "Player Stats Info:"
    })
    local v125 = game.Players.LocalPlayer
    local v126 = game:GetService("ReplicatedStorage").Player_Data[v125.Name].Stats
    local v127, v128, v129 = pairs(v126:GetChildren())
    local vu130 = {}
    local vu131 = {}
    while true do
        local v132, vu133 = v127(v128, v129)
        if v132 == nil then
            break
        end
        v129 = v132
        if vu133:IsA("NumberValue") then
            vu130[vu133.Name] = vu133.Value
            vu131[vu133.Name] = vu48.MainSection6:Label({
                Text = vu133.Name .. ": " .. tostring(vu133.Value)
            })
            vu133:GetPropertyChangedSignal("Value"):Connect(function()
                local v134 = vu133.Value
                local v135 = v134 - vu130[vu133.Name]
                local v136 = vu133.Name .. ": " .. tostring(v134)
                if v135 ~= 0 then
                    v136 = v136 .. " (+ " .. tostring(v135) .. " last match)"
                end
                vu131[vu133.Name]:UpdateName(v136)
                vu130[vu133.Name] = v134
            end)
        end
    end
    vu48.MainSection17:Divider()
    vu48.MainSection17:Header({
        Name = "Current Challenge Info:"
    })
    local v137 = game:GetService("ReplicatedStorage").Gameplay.Game.Challenge:GetChildren()
    local v138, v139, v140 = pairs(v137)
    local vu141 = {}
    local vu142 = {}
    while true do
        local v143, vu144 = v138(v139, v140)
        if v143 == nil then
            break
        end
        v140 = v143
        if vu144:IsA("ValueBase") then
            vu141[vu144.Name] = vu144.Value
            vu142[vu144.Name] = vu48.MainSection17:Label({
                Text = vu144.Name .. ": " .. tostring(vu144.Value)
            })
            vu144:GetPropertyChangedSignal("Value"):Connect(function()
                local v145 = vu144.Value
                local v146 = vu141[vu144.Name]
                local v147 = vu144.Name .. ": " .. tostring(v145)
                if v145 ~= v146 then
                    v147 = v147 .. " (changed from: " .. tostring(v146) .. ")"
                end
                vu142[vu144.Name]:UpdateName(v147)
                vu141[vu144.Name] = v145
            end)
        end
    end
    vu48.MainSection7:Divider()
    vu48.MainSection7:Header({
        Name = "Current Items Drop:"
    })
    local v148 = game:GetService("ReplicatedStorage").Gameplay.Game.Challenge:FindFirstChild("Items")
    local vu149 = {}
    local vu150 = {}
    if v148 then
        local v151, v152, v153 = pairs(v148:GetChildren())
        while true do
            local vu154
            v153, vu154 = v151(v152, v153)
            if v153 == nil then
                break
            end
            if vu154:IsA("ValueBase") then
                vu150[vu154] = vu154.Name
                vu149[vu154] = vu48.MainSection7:Label({
                    Text = vu154.Name
                })
                vu154:GetPropertyChangedSignal("Value"):Connect(function()
                    vu149[vu154]:UpdateName(vu154.Name)
                end)
                vu154:GetPropertyChangedSignal("Name"):Connect(function()
                    local v155 = vu154.Name
                    local v156 = vu150[vu154]
                    vu149[vu154]:UpdateName(v155 .. " (changed from: " .. v156 .. ")")
                    vu150[vu154] = v155
                end)
            end
        end
    end
    local v157, v158, v159 = pairs(game:GetService("ReplicatedStorage").Assets.ItemModels.Models:GetDescendants())
    local v160 = {}
    while true do
        local v161, v162 = v157(v158, v159)
        if v161 == nil then
            break
        end
        v159 = v161
        if v162:IsA("Folder") and (v162.Name ~= "Gears" and v162.Name ~= "[for-showing]") then
            local v163, v164, v165 = pairs(v162:GetChildren())
            while true do
                local v166
                v165, v166 = v163(v164, v165)
                if v165 == nil then
                    break
                end
                if v166:IsA("Model") then
                    table.insert(v160, v166.Name)
                end
            end
        end
    end
    vu48.MainSection18:Header({
        Name = "Auto-Join Specific Rewards Challenges:"
    })
    vu48.MainSection18:Dropdown({
        Name = "Auto Join X If No Rewards:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Story",
            "AFK Chamber"
        },
        Default = "",
        Callback = function(p167)
            getgenv().WaitChallenge = p167
        end
    }, "AutoCompleteForChooseRewardsSelect")
    vu48.MainSection18:Dropdown({
        Name = "Select Multi Rewards:",
        Search = true,
        Multi = true,
        Required = false,
        Options = v160,
        Default = {
            "None"
        },
        Callback = function(p168)
            getgenv().WantedItemsForChallenge = {}
            local v169, v170, v171 = pairs(p168)
            while true do
                local v172
                v171, v172 = v169(v170, v171)
                if v171 == nil then
                    break
                end
                table.insert(getgenv().WantedItemsForChallenge, v171)
            end
        end
    }, "multiitemchallengeDP")
    vu48.MainSection18:Dropdown({
        Name = "Select Action After: ",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Retry",
            "Next Stage",
            "Return To Lobby"
        },
        Default = "None",
        Callback = function(p173)
            getgenv().ActionSpecificChallenge = p173
        end
    }, "ActionSpecificChallenge")
    vu48.MainSection18:Toggle({
        Name = "TP Lobby If Specific Rewards",
        Default = false,
        Callback = function(p174)
            getgenv().AutoLobbySpecificRewards = p174
            while true do
                if not (task.wait(0.5) and getgenv().AutoLobbySpecificRewards) then
                    return
                end
                local v175 = game:GetService("Players")
                local v176 = game:GetService("ReplicatedStorage")
                local v177 = game:GetService("TeleportService")
                local v178 = v175.LocalPlayer
                local v179 = v178.PlayerGui.HUD.InGame.Main.GameInfo.Gamemode.Label.Text
                local v180 = v176:FindFirstChild("Gameplay") and (v176.Gameplay:FindFirstChild("Game") and v176.Gameplay.Game:FindFirstChild("Challenge"))
                if v180 then
                    v180 = v176.Gameplay.Game.Challenge:FindFirstChild("Items")
                end
                if not v180 then
                    return
                end
                local v181, v182, v183 = pairs(v180:GetChildren())
                local v184 = {}
                while true do
                    local v185
                    v183, v185 = v181(v182, v183)
                    if v183 == nil then
                        break
                    end
                    v184[v185.Name] = true
                end
                local v186, v187, v188 = pairs(getgenv().WantedItemsForChallenge or {})
                local v189 = false
                while true do
                    local v190
                    v188, v190 = v186(v187, v188)
                    if v188 == nil then
                        break
                    end
                    if v184[v190] then
                        v189 = true
                        break
                    end
                end
                local v191 = false
                if v178:FindFirstChild("UnitsFolder") then
                    local v192 = v178.PlayerGui:FindFirstChild("AFKChamber")
                    if v192 then
                        v192 = v178.PlayerGui.AFKChamber.Enabled
                    end
                    v191 = v179 ~= "Challenge" and (v189 and not v192) and true or (v179 == "Challenge" and not v189 and true or v191)
                end
                if v179 == "" and not v189 then
                    vu50:UpdateSelection(WaitChallenge)
                    vu68:UpdateState(true)
                end
                if v191 then
                    v177:Teleport(tonumber("72829404259339"), v178)
                end
            end
        end
    }, "AutoLobbySpecificRewardsToggle")
    local vu207 = vu48.MainSection18:Toggle({
        Name = "Auto Join Selected Rewards",
        Default = false,
        Callback = function(p193)
            getgenv().AutoJoinChallengeSelected = p193
            if game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") then
                return
            end
            while true do
                if not (task.wait(0.5) and getgenv().AutoJoinChallengeSelected) then
                    return
                end
                local v194 = game:GetService("ReplicatedStorage").Gameplay.Game.Challenge.Items
                local v195, v196, v197 = pairs(v194:GetChildren())
                local v198 = {}
                while true do
                    local v199
                    v197, v199 = v195(v196, v197)
                    if v197 == nil then
                        break
                    end
                    v198[v199.Name] = true
                end
                local v200, v201, v202 = pairs(getgenv().WantedItemsForChallenge)
                local v203 = false
                while true do
                    local v204
                    v202, v204 = v200(v201, v202)
                    if v202 == nil then
                        break
                    end
                    if v198[v204] then
                        v203 = true
                        local v205 = game:GetService("Players").LocalPlayer.PlayerGui.HUD.InGame.Main.GameInfo.Gamemode.Label.Text
                        local v206 = game:GetService("ReplicatedStorage").Remote.Server.PlayRoom.Event
                        if v205 ~= "Challenge" then
                            v206:FireServer("Create")
                            task.wait(0.5)
                            v206:FireServer("Create", {
                                CreateChallengeRoom = true
                            })
                            task.wait(0.5)
                            v206:FireServer("Start")
                        end
                        break
                    end
                end
                if not v203 then
                    task.wait(1)
                    vu50:UpdateSelection(WaitChallenge)
                    vu68:UpdateState(true)
                end
            end
        end
    }, "AutoJoinChallengeSelectedToggle")
    local vu208 = game:GetService("Players").LocalPlayer
    local vu209 = {
        "None"
    }
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UnitsLoadout") then
        local v210, v211, v212 = pairs(game:GetService("Players").LocalPlayer.PlayerGui.UnitsLoadout.Main:GetDescendants())
        while true do
            local v213
            v212, v213 = v210(v211, v212)
            if v212 == nil then
                break
            end
            if v213:IsA("Model") and v213.Parent.Name == "WorldModel" then
                table.insert(vu209, v213.Name)
            end
        end
    end
    getgenv().Unit1ForPlace = "None"
    getgenv().Unit2ForPlace = "None"
    getgenv().Unit3ForPlace = "None"
    getgenv().Unit4ForPlace = "None"
    getgenv().Unit5ForPlace = "None"
    getgenv().Unit6ForPlace = "None"
    vu48.MainSection14:Header({
        Name = "Specific Place:"
    })
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [1st]:",
        Search = true,
        Multi = false,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p214)
            getgenv().Unit1ForPlace = p214
        end
    }, "UpgradeSmartUnit1ForPlace")
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [2nd]:",
        Search = true,
        Multi = false,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p215)
            getgenv().Unit2ForPlace = p215
        end
    }, "UpgradeSmartUnit2ForPlace")
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [3rd]:",
        Multi = false,
        Search = true,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p216)
            getgenv().Unit3ForPlace = p216
        end
    }, "UpgradeSmartUnit3ForPlace")
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [4th]:",
        Multi = false,
        Search = true,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p217)
            getgenv().Unit4ForPlace = p217
        end
    }, "UpgradeSmartUnit4ForPlace")
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [5th]:",
        Multi = false,
        Search = true,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p218)
            getgenv().Unit5ForPlace = p218
        end
    }, "UpgradeSmartUnit5ForPlace")
    vu48.MainSection14:Dropdown({
        Name = "Select Unit [6th]:",
        Multi = false,
        Search = true,
        Required = false,
        Options = vu209,
        Default = "None",
        Callback = function(p219)
            getgenv().Unit6ForPlace = p219
        end
    }, "UpgradeSmartUnit6ForPlace")
    vu48.MainSection14:Input({
        Name = "Delay To Place(s):",
        Placeholder = "seconds",
        AcceptedCharacters = "All",
        Callback = function(p220)
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully set delay to " .. p220
            })
        end,
        onChanged = function(p221)
            getgenv().TimeDelayPlace = p221
        end
    }, "TimeDelayInputPlace")
    vu48.MainSection14:Toggle({
        Name = "Auto Smart Place Every X(s)",
        Default = false,
        Callback = function(p222)
            getgenv().AutoPlaceSpecific = p222
            getgenv().TimeDelayPlaceOriginal = getgenv().TimeDelayPlace
            local v223 = true
            local v224 = false
            local vu225 = false
            local function v226()
                vu225 = true
            end
            if not getgenv().AutoPlaceSpecific then
                v226()
            end
            if v223 then
                task.wait(getgenv().TimeDelayPlace)
                task.spawn(function()
                    task.wait(10)
                    getgenv().TimeDelayPlace = 0.1
                end)
                v223 = false
            end
            task.wait(getgenv().TimeDelayPlace)
            local v227 = {
                getgenv().Unit1ForPlace,
                getgenv().Unit2ForPlace,
                getgenv().Unit3ForPlace,
                getgenv().Unit4ForPlace,
                getgenv().Unit5ForPlace,
                getgenv().Unit6ForPlace
            }
            local v228, v229, v230 = ipairs(v227)
            local v231 = vu225
            while true do
                local v232
                v230, v232 = v228(v229, v230)
                if v230 == nil then
                    break
                end
                if v232 ~= "None" then
                    local v233 = game:GetService("Players").LocalPlayer.UnitsFolder:FindFirstChild(v232)
                    if v233 then
                        game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Units"):WaitForChild("Deployment"):FireServer(unpack({
                            v233
                        }))
                    end
                end
            end
            local v234 = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("RewardsUI")
            if v234 then
                v234 = v234.Enabled
            end
            if v234 then
                if not v224 then
                    getgenv().TimeDelayPlace = getgenv().TimeDelayPlaceOriginal or 1
                    task.wait(1)
                    v224 = true
                end
            elseif v224 then
                task.spawn(function()
                    task.wait(10)
                    getgenv().TimeDelayPlace = 0.1
                end)
                v224 = false
            end
            if v231 then
                return
            end
        end
    }, "AutoPlaceSpecificToggle")
    vu48.MainSection14:Toggle({
        Name = "Auto Place If Hit X Upgrade",
        Default = false,
        Callback = function(p235)
            getgenv().AutoSmartPlace = p235
            if true then
                local vu236 = true
                task.spawn(function()
                    while true do
                        if not getgenv().AutoSmartPlace then
                            vu236 = false
                            return
                        end
                        local v237 = {
                            getgenv().Unit1 or "None",
                            getgenv().Unit2 or "None",
                            getgenv().Unit3 or "None",
                            getgenv().Unit4 or "None",
                            getgenv().Unit5 or "None",
                            getgenv().Unit6 or "None"
                        }
                        local v238 = {
                            tonumber(getgenv().SmartUpgrade1),
                            tonumber(getgenv().SmartUpgrade2),
                            tonumber(getgenv().SmartUpgrade3),
                            tonumber(getgenv().SmartUpgrade4),
                            tonumber(getgenv().SmartUpgrade5),
                            tonumber(getgenv().SmartUpgrade6)
                        }
                        local v239 = game:GetService("Players").LocalPlayer
                        local v240 = v239.PlayerGui.HUD.InGame.UnitsManager.Main.Main.ScrollingFrame
                        local v241 = game:GetService("ReplicatedStorage").Remote.Server.Units.Deployment
                        for v242 = 1, # v237 do
                            if not getgenv().AutoSmartPlace then
                                break
                            end
                            local v243 = v237[v242]
                            local v244 = v238[v242]
                            if v243 ~= "None" then
                                if v244 then
                                    local v245 = v240:FindFirstChild(v243)
                                    local v246
                                    if v245 then
                                        v246 = v245:FindFirstChild("UpgradeText")
                                    else
                                        v246 = v245
                                    end
                                    if v245 then
                                        if v246 then
                                            local v247, v248, v249 = v246.Text:gmatch("%d+")
                                            local v250 = 0
                                            while true do
                                                v249 = v247(v248, v249)
                                                if v249 == nil then
                                                    break
                                                end
                                                v250 = tonumber(v249)
                                            end
                                            if v244 <= v250 then
                                                local v251 = v239:WaitForChild("UnitsFolder"):FindFirstChild(v243)
                                                if v251 then
                                                    v241:FireServer(v251)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        task.wait(0.7)
                    end
                end)
            end
        end
    }, "AutoPUpgradeBasedToggle")
    vu48.MainSection14:Paragraph({
        Header = "Note:",
        Body = "Auto Smart Place Units change to 0,1s delay after 10s. Its auto change back to old delay time once u win/lose then repeat."
    })
    vu48.MainSection8:Header({
        Name = "Specific Upgrades:"
    });
    (function()
        local v252, v253, vu254 = ipairs({
            {
                name = "Select Unit [1st]:",
                key = "Unit1"
            },
            {
                name = "Select Unit [2nd]:",
                key = "Unit2"
            },
            {
                name = "Select Unit [3rd]:",
                key = "Unit3"
            },
            {
                name = "Select Unit [4th]:",
                key = "Unit4"
            },
            {
                name = "Select Unit [5th]:",
                key = "Unit5"
            },
            {
                name = "Select Unit [6th]:",
                key = "Unit6"
            }
        })
        while true do
            local vu255
            vu254, vu255 = v252(v253, vu254)
            if vu254 == nil then
                break
            end
            vu48.MainSection8:Dropdown({
                Name = vu255.name,
                Search = true,
                Multi = false,
                Required = false,
                Options = vu209,
                Default = "None",
                Callback = function(p256)
                    getgenv()[vu255.key] = p256
                end
            }, "UpgradeSmartUnit" .. vu254)
            vu48.MainSection8:Input({
                Name = "Number To Upgrade [" .. vu254 .. (vu254 == 1 and "st]:" or vu254 == 2 and "nd]:" or (vu254 == 3 and "rd]:" or "th]:")),
                Placeholder = "",
                AcceptedCharacters = "All",
                Callback = function(p257)
                    vu26:Notify({
                        Title = vu26.Settings.Title,
                        Description = "Successfully set input to " .. p257
                    })
                end,
                onChanged = function(p258)
                    getgenv()["SmartUpgrade" .. vu254] = p258
                end
            }, "MaxUpgrade" .. vu254)
        end
    end)()
    vu48.MainSection10:Input({
        Name = "Delay To Upgrade(s):",
        Placeholder = "seconds",
        AcceptedCharacters = "All",
        Callback = function(p259)
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully set delay to " .. p259
            })
        end,
        onChanged = function(p260)
            getgenv().TimeDelayUpgrade = p260
        end
    }, "TimeDelayInputUpgrade")
    vu48.MainSection10:Toggle({
        Name = "Auto Upgrade Selected Units",
        Default = false,
        Callback = function(p261)
            getgenv().AutoSmartUpgrade = p261
            local vu262 = false
            function StartSmartUpgrade()
                if not vu262 then
                    vu262 = true
                    task.spawn(function()
                        while true do
                            if not getgenv().AutoSmartUpgrade then
                                vu262 = false
                                return
                            end
                            local v263 = {}
                            local v264 = {}
                            for v265 = 1, 6 do
                                v263[v265] = getgenv()["Unit" .. v265] or "None"
                                v264[v265] = tonumber(getgenv()["SmartUpgrade" .. v265])
                            end
                            local v266 = game:GetService("Players").LocalPlayer
                            local v267 = v266.PlayerGui.HUD.InGame.UnitsManager.Main.Main.ScrollingFrame
                            local v268 = game:GetService("ReplicatedStorage").Remote.Server.Units.Upgrade
                            for v269 = 1, # v263 do
                                if not getgenv().AutoSmartUpgrade then
                                    break
                                end
                                local v270 = v263[v269]
                                local v271 = v264[v269]
                                if v270 ~= "None" then
                                    if v271 then
                                        local v272 = v267:FindFirstChild(v270)
                                        local v273
                                        if v272 then
                                            v273 = v272:FindFirstChild("UpgradeText")
                                        else
                                            v273 = v272
                                        end
                                        if v272 then
                                            if v273 then
                                                local v274, v275, v276 = v273.Text:gmatch("%d+")
                                                local v277 = 0
                                                while true do
                                                    v276 = v274(v275, v276)
                                                    if v276 == nil then
                                                        break
                                                    end
                                                    v277 = tonumber(v276)
                                                end
                                                if v277 < v271 then
                                                    local v278 = v266:WaitForChild("UnitsFolder"):FindFirstChild(v270)
                                                    if v278 then
                                                        task.wait(getgenv().TimeDelayUpgrade or 1)
                                                        v268:FireServer(v278)
                                                        for _ = 1, 10 do
                                                            task.wait(0.2)
                                                            local v279 = v267:FindFirstChild(v270)
                                                            if v279 then
                                                                v279 = v279:FindFirstChild("UpgradeText")
                                                            end
                                                            if v279 then
                                                                local v280, v281, v282 = v279.Text:gmatch("%d+")
                                                                local v283 = 0
                                                                while true do
                                                                    v282 = v280(v281, v282)
                                                                    if v282 == nil then
                                                                        break
                                                                    end
                                                                    v283 = tonumber(v282)
                                                                end
                                                                if v277 < v283 then
                                                                    break
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
            StartSmartUpgrade()
        end
    }, "AutoSmartUpgradeToggle")
    vu48.MainSection10:Toggle({
        Name = "Auto Up Max Slot 1 -> 6",
        Default = false,
        Callback = function(p284)
            getgenv().Start = p284
            task.spawn(function()
                local v285 = game:GetService("Players")
                local v286 = game:GetService("RunService")
                local v287 = v285.LocalPlayer
                local v288 = v287.PlayerGui.UnitsLoadout.Main
                local v289 = v287.PlayerGui.HUD.InGame.UnitsManager.Main.Main.ScrollingFrame
                local v290 = {
                    "UnitLoadout1",
                    "UnitLoadout2",
                    "UnitLoadout3",
                    "UnitLoadout4",
                    "UnitLoadout5",
                    "UnitLoadout6"
                }
                while true do
                    if not task.wait(0.5) or getgenv().Start ~= true then
                        return
                    end
                    if game.Players.LocalPlayer.PlayerGui.HUD.InGame.VotePlaying.Visible == false then
                        local v291, v292, v293 = ipairs(v290)
                        while true do
                            local v294
                            v293, v294 = v291(v292, v293)
                            if v293 == nil then
                                break
                            end
                            local v295 = v288:FindFirstChild(v294)
                            if v295 and (v295:IsA("TextButton") and v295:GetAttribute("OnTemplateUnit") ~= "null") then
                                local v296 = tostring(v295.Frame.UnitFrame.Info.Folder.Value)
                                local v297 = v289:WaitForChild(v296):WaitForChild("UpgradeText")
                                while getgenv().Start do
                                    if string.find(v297.Text, "%(MAX%)") then
                                        print(v296 .. " is fully upgraded!")
                                        break
                                    end
                                    local v298 = {
                                        game:GetService("Players").LocalPlayer.UnitsFolder[v296]
                                    }
                                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Units"):WaitForChild("Upgrade"):FireServer(unpack(v298))
                                    v286.Heartbeat:Wait()
                                end
                            end
                        end
                    end
                end
            end)
        end
    }, "AutoUpgradeFromLeftToRightToggle")
    vu48.MainSection10:Toggle({
        Name = "Auto Random Upgrade",
        Default = false,
        Callback = function(p299)
            getgenv().AutoRandomUpgrade = p299
            task.spawn(function()
                while getgenv().AutoRandomUpgrade do
                    local v300, v301, v302 = pairs(game:GetService("Players").LocalPlayer.UnitsFolder:GetChildren())
                    while true do
                        local v303
                        v302, v303 = v300(v301, v302)
                        if v302 == nil or not getgenv().AutoRandomUpgrade then
                            break
                        end
                        game:GetService("ReplicatedStorage").Remote.Server.Units.Upgrade:FireServer(v303)
                    end
                    task.wait(0.5)
                end
            end)
        end
    }, "AutoRandomUpgradeToggle")
    vu48.MainSection11:Header({
        Text = "All Rangers Auto Join:"
    })
    local vu305 = vu48.MainSection11:Dropdown({
        Name = "Auto Join X After Done All:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Story",
            "Raid",
            "Challenge",
            "Infinity Castle",
            "Portal",
            "AFK Chamber"
        },
        Default = "",
        Callback = function(p304)
            getgenv().WaitRangers = p304
        end
    }, "AutoCompleteForChooseSelect")
    local vu334 = vu48.MainSection11:Toggle({
        Name = "Auto Complete All Rangers Stage",
        Default = false,
        Callback = function(p306)
            getgenv().AutoCompleteRangersStage = p306
            if not game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") then
                if vu68 and vu68.State == true then
                    vu68:UpdateState(false)
                end
                task.spawn(function()
                    while true do
                        if not (task.wait(0.5) and getgenv().AutoCompleteRangersStage) then
                            return
                        end
                        local v307 = game:GetService("Players").LocalPlayer
                        v307.PlayerGui.PlayRoom.Enabled = true
                        task.wait(0.9)
                        vu24("Create")
                        vu24("Change-Mode", {
                            Mode = "Ranger Stage"
                        })
                        local v308 = {
                            "OnePiece",
                            "Namek",
                            "DemonSlayer",
                            "Naruto",
                            "OPM",
                            "TokyoGhoul"
                        }
                        local v309, v310, v311 = ipairs(v308)
                        while true do
                            local v312
                            v311, v312 = v309(v310, v311)
                            if v311 == nil then
                                break
                            end
                            vu24("Change-World", {
                                World = v312
                            })
                            task.wait(0.5)
                        end
                        local v313 = v307.PlayerGui.PlayRoom.Main.GameStage.Main.Base.Chapter:GetDescendants()
                        local v314, v315, v316 = pairs(v313)
                        local v317 = true
                        while true do
                            local v318
                            v316, v318 = v314(v315, v316)
                            if v316 == nil then
                                break
                            end
                            if v318:IsA("Frame") and (v318.Name == "RangerStageLock" and v318.Visible == false) then
                                v317 = false
                                break
                            end
                        end
                        if v317 then
                            getgenv().AutoCompleteRangersStage = false
                            task.wait(1)
                            vu24("Remove")
                            vu21(v307.PlayerGui.PlayRoom.Main.Button.Leave)
                            task.wait(1)
                            vu50:UpdateSelection(getgenv().WaitRangers)
                            vu68:UpdateState(true)
                        end
                        local v319, v320, v321 = ipairs(v308)
                        local v322 = false
                        while true do
                            local v323
                            v321, v323 = v319(v320, v321)
                            if v321 == nil or v322 then
                                break
                            end
                            for v324 = 1, v323 == "TokyoGhoul" and 5 or 3 do
                                if v322 then
                                    break
                                end
                                local v325 = "RangerStage" .. v324
                                local v326, v327, v328 = pairs(v313)
                                while true do
                                    local v329
                                    v328, v329 = v326(v327, v328)
                                    if v328 == nil then
                                        break
                                    end
                                    if v329:IsA("Frame") and (v329.Name == "RangerStageLock" and v329.Visible == false) then
                                        local v330 = v329.Parent.Parent
                                        local v331 = tostring(v330.Name)
                                        local v332, v333 = string.match(v331, "([^_]+)_([^_]+)")
                                        if v332 == v323 and v333 == v325 then
                                            print(" tryna join : " .. v332 .. " and " .. v331)
                                            vu24("Change-World", {
                                                World = v332
                                            })
                                            task.wait(0.5)
                                            vu24("Change-Chapter", {
                                                Chapter = v331
                                            })
                                            task.wait(0.5)
                                            vu24("Submit")
                                            task.wait(0.5)
                                            vu24("Start")
                                            v322 = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    }, "AutoCompleteAllRangersStage")
    vu48.MainSection11:Toggle({
        Name = "TP Lobby If All Ranger Unlocked",
        Default = false,
        Callback = function(p335)
            getgenv().AutoLobby = p335
            task.spawn(function()
                while getgenv().AutoLobby do
                    local v336 = game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].RangerStage
                    local v337 = game:GetService("Players").LocalPlayer.PlayerGui.HUD.InGame.Main.GameInfo.Gamemode.Label.Text
                    if game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") and (v337 ~= "Ranger Stage" and # v336:GetChildren() == 0) then
                        game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                        break
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.AFKChamber.Enabled and # v336:GetChildren() == 0 then
                        game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                        break
                    end
                    if game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") == nil and (vu50.Value == "Portal" and (vu68.State == true and (getgenv().FoundPortal == "False" and # v336:GetChildren() == 0))) then
                        print("not found portal  + portal join on so waiting for all rangers rn and tp lobby and join them")
                        game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                        break
                    end
                    task.wait(0.5)
                end
            end)
        end
    }, "AutoLobbyToggle")
    vu48.MainSection11:Button({
        Name = "Reset Selected",
        Callback = function()
            vu305:UpdateSelection("None")
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully Reset Selected!"
            })
        end
    })
    vu48.MainSection16:Header({
        Text = "Specific Multiple Rangers Auto Join:"
    })
    local vu339 = vu48.MainSection16:Dropdown({
        Name = "Auto Join X After Done All:",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Story",
            "Raid",
            "Challenge",
            "Infinity Castle",
            "Portal",
            "AFK Chamber"
        },
        Default = "",
        Callback = function(p338)
            getgenv().WaitRangersSpecific = p338
        end
    }, "AutoCompleteForChooseSelectSpecific")
    local v340, v341, v342 = ipairs({
        "OnePiece",
        "Namek",
        "DemonSlayer",
        "Naruto",
        "OPM",
        "TokyoGhoul"
    })
    local v343 = {}
    while true do
        local v344
        v342, v344 = v340(v341, v342)
        if v342 == nil then
            break
        end
        for v345 = 1, v344 == "TokyoGhoul" and 5 or 3 do
            table.insert(v343, v344 .. "_RangerStage" .. v345)
        end
    end
    local vu350 = vu48.MainSection16:Dropdown({
        Name = "Select Multi Specific Rangers:",
        Search = true,
        Multi = true,
        Required = false,
        Options = v343,
        Default = {
            "None"
        },
        Callback = function(p346)
            getgenv().WantedRangers = {}
            local v347, v348, v349 = pairs(p346)
            while true do
                v349 = v347(v348, v349)
                if v349 == nil then
                    break
                end
                table.insert(getgenv().WantedRangers, v349)
            end
        end
    }, "MultiSpecificRangerDP")
    vu48.MainSection16:Dropdown({
        Name = "Select Action After: ",
        Search = true,
        Multi = false,
        Required = true,
        Options = {
            "Retry",
            "Next Stage",
            "Return To Lobby"
        },
        Default = "None",
        Callback = function(p351)
            getgenv().ActionSpecific = p351
        end
    }, "ActionSpecific")
    local _ = game:GetService("Players").LocalPlayer.PlayerGui.PlayRoom.Main.GameStage.Main.Base.Chapter
    local vu385 = vu48.MainSection16:Toggle({
        Name = "Auto Complete Specific Rangers Stages",
        Default = false,
        Callback = function(p352)
            getgenv().AutoSpecificRangers = p352
            if not game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") then
                if vu68 and vu68.State then
                    vu68:UpdateState(false)
                end
                task.spawn(function()
                    local v353 = game:GetService("Players").LocalPlayer
                    local v354 = v353.PlayerGui.PlayRoom.Main.GameStage.Main.Base.Chapter
                    table.sort(WantedRangers, function(p355, p356)
                        local v357, v358 = string.match(p355, "([^_]+)_RangerStage(%d+)")
                        local v359, v360 = string.match(p356, "([^_]+)_RangerStage(%d+)")
                        local v361 = {
                            OnePiece = 1,
                            Namek = 2,
                            DemonSlayer = 3,
                            Naruto = 4,
                            OPM = 5,
                            TokyoGhoul = 6
                        }
                        if v357 == v359 then
                            return tonumber(v358) < tonumber(v360)
                        else
                            return v361[v357] < v361[v359]
                        end
                    end)
                    local v362 = {}
                    while getgenv().AutoSpecificRangers do
                        v353.PlayerGui.PlayRoom.Enabled = true
                        task.wait(0.6)
                        vu24("Create")
                        task.wait(0.3)
                        vu24("Change-Mode", {
                            Mode = "Ranger Stage"
                        })
                        local v363, v364, v365 = ipairs({
                            "OnePiece",
                            "Namek",
                            "DemonSlayer",
                            "Naruto",
                            "OPM",
                            "TokyoGhoul"
                        })
                        while true do
                            local v366
                            v365, v366 = v363(v364, v365)
                            if v365 == nil then
                                break
                            end
                            vu24("Change-World", {
                                World = v366
                            })
                            local v367 = 6
                            while 0 < v367 and not v354:FindFirstChild(v366) do
                                task.wait(0.2)
                                v367 = v367 - 0.2
                            end
                        end
                        local v368, v369, v370 = ipairs(WantedRangers)
                        while true do
                            local v371
                            v370, v371 = v368(v369, v370)
                            if v370 == nil then
                                break
                            end
                            local vu372 = false
                            local function v373()
                                vu372 = true
                            end
                            if not getgenv().AutoSpecificRangers then
                                v373()
                            end
                            if not v362[v371] then
                                local v374 = string.match(v371, "([^_]+)_")
                                vu24("Change-World", {
                                    World = v374
                                })
                                local v375 = 5
                                while 0 < v375 and not v354:FindFirstChild(v374) do
                                    task.wait(0.2)
                                    v375 = v375 - 0.2
                                end
                                local v376 = 5
                                while v376 > 0 do
                                    if v354[v374] and v354[v374]:FindFirstChild(v371) then
                                        v373()
                                    end
                                    task.wait(0.2)
                                    v376 = v376 - 0.2
                                end
                                local v377 = 5
                                while v377 > 0 do
                                    local v378 = v354[v374]:FindFirstChild(v371)
                                    if v378 and v378.Inner:FindFirstChild("RangerStageLock") then
                                        v373()
                                    end
                                    task.wait(0.2)
                                    v377 = v377 - 0.2
                                end
                                local v379 = v354[v374]
                                if v379 then
                                    v379 = v354[v374]:FindFirstChild(v371)
                                end
                                if v379 and (v379.Inner:FindFirstChild("RangerStageLock") and v379.Inner.RangerStageLock.Visible == false) then
                                    print("\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 Trying:", v371, " | World:", v374)
                                    vu24("Change-Chapter", {
                                        Chapter = v371
                                    })
                                    task.wait(0.2)
                                    vu24("Submit")
                                    task.wait(0.2)
                                    vu24("Start")
                                    v362[v371] = true
                                    print("\239\191\189\239\191\189 Completed:", v371)
                                    v373()
                                else
                                    print("\239\191\189\239\191\189 Skipped or Locked:", v371)
                                    v362[v371] = true
                                end
                            end
                            if vu372 then
                                break
                            end
                        end
                        local v380, v381, v382 = ipairs(WantedRangers)
                        local v383 = true
                        while true do
                            local v384
                            v382, v384 = v380(v381, v382)
                            if v382 == nil then
                                break
                            end
                            if not v362[v384] then
                                v383 = false
                                break
                            end
                        end
                        if v383 then
                            print("\239\191\189\239\191\189 All stages completed. Switching to after process.")
                            getgenv().AutoSpecificRangers = false
                            vu24("Remove")
                            vu21(v353.PlayerGui.PlayRoom.Main.Button.Leave)
                            task.wait(1)
                            vu50:UpdateSelection(WaitRangersSpecific)
                            vu68:UpdateState(true)
                        end
                        task.wait(0.5)
                    end
                end)
            end
        end
    }, "AutoSpecificRangersStage")
    vu48.MainSection16:Toggle({
        Name = "TP Lobby If Specific Unlocked",
        Default = false,
        Callback = function(p386)
            getgenv().AutoLobbySpecific = p386
            while true do
                if not getgenv().AutoLobbySpecific then
                    return
                end
                local v387 = game:GetService("Players").LocalPlayer.PlayerGui.HUD.InGame.Main.GameInfo.Gamemode.Label.Text
                if game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") and v387 ~= "Ranger Stage" then
                    local v388 = game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].RangerStage
                    local v389, v390, v391 = pairs(v388:GetChildren())
                    local v392 = {}
                    while true do
                        local v393
                        v391, v393 = v389(v390, v391)
                        if v391 == nil then
                            break
                        end
                        v392[v393.Name] = true
                    end
                    local v394, v395, v396 = pairs(getgenv().WantedRangers)
                    while true do
                        local v397
                        v396, v397 = v394(v395, v396)
                        if v396 == nil then
                            break
                        end
                        if not v392[v397] then
                            game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                            break
                        end
                    end
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.AFKChamber.Enabled == true then
                    local v398 = game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].RangerStage
                    local v399, v400, v401 = pairs(v398:GetChildren())
                    local v402 = {}
                    while true do
                        local v403
                        v401, v403 = v399(v400, v401)
                        if v401 == nil then
                            break
                        end
                        v402[v403.Name] = true
                    end
                    local v404, v405, v406 = pairs(getgenv().WantedRangers)
                    while true do
                        local v407
                        v406, v407 = v404(v405, v406)
                        if v406 == nil then
                            break
                        end
                        if not v402[v407] then
                            game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                            break
                        end
                    end
                end
                if game:GetService("Players").LocalPlayer:FindFirstChild("UnitsFolder") == nil and (vu50.Value == "Portal" and (vu68.State == true and getgenv().FoundPortal == "False")) then
                    print("not found portal  + portal join on so finding specific rangers rn and tp lobby and join them")
                    local v408 = game:GetService("ReplicatedStorage").Player_Data[game.Players.LocalPlayer.Name].RangerStage
                    local v409, v410, v411 = pairs(v408:GetChildren())
                    local v412 = {}
                    while true do
                        local v413
                        v411, v413 = v409(v410, v411)
                        if v411 == nil then
                            break
                        end
                        v412[v413.Name] = true
                    end
                    local v414, v415, v416 = pairs(getgenv().WantedRangers)
                    while true do
                        local v417
                        v416, v417 = v414(v415, v416)
                        if v416 == nil then
                            break
                        end
                        if not v412[v417] then
                            game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                            break
                        end
                    end
                end
                task.wait(0.5)
            end
        end
    }, "AutoLobbySpecificToggle")
    vu48.MainSection16:Button({
        Name = "Reset Selected",
        Callback = function()
            vu350:UpdateSelection("None")
            vu339:UpdateSelection("None")
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully Reset Selected!"
            })
        end
    })
    vu48.MainSection16:Paragraph({
        Header = "Note:",
        Body = "Select Action After For Specific Rangers is FOR RANGERS ONLY."
    })
    vu48.MainSection11:Paragraph({
        Header = "How to use Auto Complete:",
        Body = "Auto-Complete auto set next stage, other modes auto set retry. \n\nIf you completed all Rangers, it\'s auto do the thing u selected while waiting rangers unlocked all. \n\n MAKE SURE TO SELECT CONFIG"
    })
    vu48.MainSection12:Header({
        Name = "Webhook:"
    })
    vu48.MainSection12:Dropdown({
        Name = "Select Items To Notify:",
        Search = true,
        Multi = true,
        Required = false,
        Options = {
            "Everything",
            "Onigiri",
            "Sunrise Earrings",
            "Blood Ember",
            "Cursed Core",
            "Dark Essence",
            "Demon Fang Shard",
            "Moonroot Herb",
            "Flame Seal Tag",
            "Mirror Lens",
            "Soul Core",
            "Slayer Stone Fragment",
            "Stats Key",
            "Perfect Stats Key",
            "Cursed Finger",
            "Dr. Megga Punk",
            "Trait Reroll",
            "Ranger Crystal",
            "Luck Potion",
            "Green Bean",
            "Narmekian Ore",
            "Power Core",
            "Dracoscale Shard",
            "Arcane Dust",
            "Narmekian Crystal",
            "Nano Fiber Wire",
            "Micro Circuit Board",
            "Phantom Alloy",
            "Enhanced Optical Lens",
            "Energy Vial",
            "Ramen",
            "Storm Flake Crystal",
            "Shadow Fiber",
            "Seal of Gale",
            "Chakra Shard",
            "Ancient Talisman",
            "Smoke Orb",
            "Scroll of Focus",
            "Kunai Shards",
            "Core of Silence",
            "French Fries",
            "Alpha Dust",
            "Blast Cell",
            "Chaos Bone Shard",
            "Surge Nucleus",
            "Mutant Core Fragment",
            "Genesis Matrix",
            "Neurochip Beta",
            "Tactical Frame",
            "SYN-Core",
            "Rubber Fruit",
            "Sea Gem Fragment",
            "Soul Shard",
            "Mystic Kelp",
            "Will Core",
            "Void Pearl",
            "Obsidian Plate",
            "Marine Tech Chip",
            "Combat Fluid",
            "Ghost Lens",
            "Ancient Power Core",
            "Bunny Bounce Boots",
            "Carrot Cutter",
            "Fluffy Focus",
            "Furrocious Fluff",
            "Gourmet Meal",
            "Ribe\'s RC Cells",
            "Ujaku Feather",
            "Biaiku Scale",
            "Kakuja Mask Shard",
            "Centipede Husk",
            "Ghoul City Portal I",
            "CGGG Investigator\'s Badge",
            "Yoshimarun\'s Mask Fragment",
            "Arata Armor Piece",
            "One-Eyed Fragment",
            "Ghoul City Portal II",
            "Ghoul City Portal III",
            "Eto_Yoshimura",
            "RCCells"
        },
        Default = {
            "None"
        },
        Callback = function(p418)
            getgenv().WantedNotify = {}
            local v419, v420, v421 = pairs(p418)
            while true do
                v421 = v419(v420, v421)
                if v421 == nil then
                    break
                end
                table.insert(getgenv().WantedNotify, v421)
            end
        end
    }, "UnitorItemsDP")
    vu48.MainSection12:Input({
        Name = "Enter Url:",
        Placeholder = "",
        AcceptedCharacters = "All",
        Callback = function(p422)
            vu26:Notify({
                Title = vu26.Settings.Title,
                Description = "Successfully set url to " .. p422
            })
        end,
        onChanged = function(p423)
            getgenv().Url = tostring(p423)
        end
    }, "WebhookURL")
    local vu487 = vu48.MainSection12:Toggle({
        Name = "Auto Send After Win/Lose",
        Default = false,
        Callback = function(p424)
            getgenv().AutoSendWebhook = p424
            local vu425 = false
            local vu426 = game.Players.LocalPlayer
            local vu427 = game:GetService("HttpService")
            function SendMessageEMBED(p428, p429, p430)
                local v431 = {
                    content = p430 and "@everyone" or nil,
                    embeds = {
                        {
                            title = p429.title,
                            description = p429.description,
                            color = p429.color or 16777215,
                            fields = p429.fields,
                            footer = {
                                text = p429.footer.text,
                                icon_url = p429.footer.icon_url
                            },
                            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                        }
                    }
                }
                (syn and syn.request or request)({
                    Url = p428,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = vu427:JSONEncode(v431)
                })
            end
            vu426.PlayerGui.RewardsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
                if not vu426.PlayerGui.RewardsUI.Enabled then
                    vu425 = false
                end
            end)
            local v432 = vu425
            local v433 = vu426
            while true do
                if not getgenv().AutoSendWebhook then
                    return
                end
                local v434 = v433.PlayerGui.RewardsUI
                if v434.Enabled and not v432 then
                    vu425 = true
                    local v435 = "[" .. game:GetService("ReplicatedStorage").Player_Data[v433.Name].Data.Level.Value .. "] ||" .. v433.Name .. "||"
                    local v436 = v434.Main.LeftSide.GameStatus.Text
                    local v437 = v434.Main.LeftSide.World.Text
                    local _ = v434.Main.LeftSide.Mode.Text
                    local v438 = v434.Main.LeftSide.Chapter.Text
                    local v439 = v434.Main.LeftSide.Difficulty.Text
                    local v440 = v434.Main.LeftSide.TotalTime.Text
                    local v441 = {}
                    local v442 = {}
                    local v443 = {}
                    local v444 = {}
                    local v445 = {}
                    local v446 = v433:FindFirstChild("RewardsShow")
                    if v446 then
                        local v447, v448, v449 = pairs(v446:GetChildren())
                        v432 = vu425
                        while true do
                            local v450
                            v449, v450 = v447(v448, v449)
                            if v449 == nil then
                                break
                            end
                            if v450:IsA("Folder") and v450:FindFirstChild("Amount") then
                                local v451 = v450.Name
                                local v452 = v450.Amount.Value
                                if v451 == "Exp" or (v451 == "Gold" or v451 == "Gem") then
                                    local v453 = game:GetService("ReplicatedStorage").Player_Data[v433.Name].Data[v451].Value
                                    table.insert(v441, v451 .. "(+" .. v452 .. ")" .. " | Total: " .. v453)
                                else
                                    local v454 = game:GetService("ReplicatedStorage").Player_Data[v433.Name]:FindFirstChild("Items")
                                    if v454 and v454:FindFirstChild(v451) then
                                        local v455 = v454[v451].Amount.Value
                                        table.insert(v442, v451 .. "(+" .. v452 .. ")" .. " | Total: " .. v455)
                                    else
                                        table.insert(v443, v451)
                                    end
                                end
                            end
                        end
                    else
                        table.insert(v441, "Found no reward.")
                        table.insert(v442, "Found no reward.")
                        table.insert(v444, "Found no extra items or units.")
                        v432 = vu425
                    end
                    local v456, v457, v458 = ipairs(v443)
                    while true do
                        local v459
                        v458, v459 = v456(v457, v458)
                        if v458 == nil then
                            break
                        end
                        v445[v459] = (v445[v459] or 0) + 1
                    end
                    local v460, v461, v462 = pairs(v445)
                    local v463 = {}
                    while true do
                        local v464
                        v462, v464 = v460(v461, v462)
                        if v462 == nil then
                            break
                        end
                        table.insert(v463, {
                            name = v462,
                            count = v464
                        })
                    end
                    table.sort(v463, function(p465, p466)
                        return p465.count > p466.count
                    end)
                    local v467, v468, v469 = ipairs(v463)
                    while true do
                        local v470
                        v469, v470 = v467(v468, v469)
                        if v469 == nil then
                            break
                        end
                        table.insert(v444, v470.name .. " x" .. v470.count)
                    end
                    local v471, v472, v473 = pairs(game:GetService("Players").LocalPlayer.UnitsFolder:GetChildren())
                    local v474 = {}
                    while true do
                        local v475
                        v473, v475 = v471(v472, v473)
                        if v473 == nil then
                            break
                        end
                        if v475:IsA("Folder") then
                            table.insert(v474, "[" .. v475.Level.Value .. "] " .. v475.Name .. " = [" .. v475.Takedown.Value .. "\239\191\189\239\191\189\239\184\143]" .. " | \226\156\168 [" .. v475.Worthless.Value .. "%]")
                        end
                    end
                    getgenv().Number = v436 == "~ WON" and 65280 or 16711680
                    local v476 = v433:FindFirstChild("RewardsShow")
                    local v477, v478, v479 = pairs(getgenv().WantedNotify)
                    while true do
                        local v480
                        v479, v480 = v477(v478, v479)
                        if v479 == nil then
                            break
                        end
                        local v481 = false
                        if v476 then
                            local v482, v483, v484 = pairs(v476:GetChildren())
                            while true do
                                local v485
                                v484, v485 = v482(v483, v484)
                                if v484 == nil then
                                    break
                                end
                                if v480 == tostring(v485) then
                                    v481 = true
                                    break
                                end
                            end
                        end
                        if v481 or (v480 == "Everything" or not v476) then
                            local v486 = {
                                title = "Anime Rangers X | ПОТУЖНИЙ ЧIТ",
                                color = tonumber(getgenv().Number),
                                fields = {
                                    {
                                        name = "NAME:",
                                        value = v435,
                                        inline = false
                                    },
                                    {
                                        name = "\nRESULT:",
                                        value = v437 .. v436 .. "\n" .. v438 .. " - ( " .. v439 .. " )\n" .. v440
                                    },
                                    {
                                        name = "\nUNITS INFO:",
                                        value = table.concat(v474, "\n")
                                    },
                                    {
                                        name = "\nCURRENCY:",
                                        value = table.concat(v441, "\n")
                                    },
                                    {
                                        name = "\nREWARDS:",
                                        value = table.concat(v442, "\n")
                                    },
                                    {
                                        name = "\nEXTRA THINGS DROPPED:",
                                        value = table.concat(v444, "\n")
                                    }
                                },
                                footer = {
                                    text = "ПОТУЖНИЙ ЧIТ",
                                    icon_url = ""
                                }
                            }
                            if v481 then
                                v481 = v480 ~= "Everything"
                            end
                            SendMessageEMBED(getgenv().Url, v486, v481)
                        end
                    end
                end
                task.wait(0.5)
            end
        end
    }, "AutoSendWebhook")
    vu48.MainSection12:Paragraph({
        Header = "About Rewards:",
        Body = "Webhook will only send when u turn on Auto-Do Action. \n\n Webhook auto ping @everyone if you select specific units/items \n\n You can select multiples specific items. \n\n If there are no rewards, webhook will send notify in ur game instead of discord."
    })
    vu48.MainSection3:Toggle({
        Name = "Auto Do Selected Action",
        Default = false,
        Callback = function(p488)
            getgenv().AutoAfterWinLose = p488
            while getgenv().AutoAfterWinLose do
                local v489 = game:GetService("Players").LocalPlayer.PlayerGui.HUD.InGame.Main.GameInfo.Gamemode.Label.Text
                local v490 = game:GetService("Players").LocalPlayer.PlayerGui.RewardsUI.Main.LeftSide.Chapter.Text
                if vu334 and vu334.State then
                    if v489 == "Ranger Stage" and v490 == "Act 5 - Wings of the Abyss" then
                        vu96:UpdateSelection("Return To Lobby")
                    elseif v489 == "Ranger Stage" then
                        vu96:UpdateSelection("Next Stage")
                    elseif v489 == "Challenge" or v489 == "Story" then
                        vu96:UpdateSelection("Retry")
                    elseif v489 == "Portal" then
                        vu96:UpdateSelection("Return To Lobby")
                    end
                elseif vu385 and vu385.State then
                    if v489 == "Ranger Stage" and v490 == "Act 5 - Wings of the Abyss" then
                        vu96:UpdateSelection("Return To Lobby")
                    elseif v489 == "Ranger Stage" then
                        vu96:UpdateSelection(ActionSpecific)
                    elseif v489 == "Challenge" or v489 == "Story" then
                        vu96:UpdateSelection("Retry")
                    elseif v489 == "Portal" then
                        vu96:UpdateSelection("Return To Lobby")
                    end
                elseif vu207 and (vu207.State and (v489 == "Challenge" or v489 == "Story")) then
                    vu96:UpdateSelection(ActionSpecificChallenge)
                end
                local v491 = game:GetService("Players").LocalPlayer.PlayerGui
                local v492 = v491.RewardsUI
                local v493 = v491.Visual:FindFirstChild("Showcase_Units")
                if getgenv().Method ~= "Retry" then
                    if getgenv().Method ~= "Next Stage" then
                        if getgenv().Method == "Return To Lobby" then
                            if v493 and not v492.Enabled then
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                            elseif v492.Enabled then
                                if vu487 and vu487.State then
                                    task.wait(1.2)
                                end
                                game:GetService("TeleportService"):Teleport(72829404259339, game.Players.LocalPlayer)
                                break
                            end
                        end
                    elseif v493 and not v492.Enabled then
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    elseif v492.Enabled then
                        local v494 = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteNext")
                        if vu487 and vu487.State then
                            task.wait(1.2)
                            v494:FireServer()
                        else
                            v494:FireServer()
                        end
                    end
                elseif v493 and not v492.Enabled then
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                elseif v492.Enabled then
                    local v495 = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("OnGame"):WaitForChild("Voting"):WaitForChild("VoteRetry")
                    if vu487 and vu487.State then
                        task.wait(1.2)
                        v495:FireServer()
                    else
                        v495:FireServer()
                    end
                end
                task.wait(0.2)
            end
        end
    }, "AutoAfterWinLoseToggle")
    vu48.MainSection19:Header({
        Name = "Auto-Craft:"
    })
    getgenv().WantedEvoItems = {}
    vu48.MainSection19:Dropdown({
        Name = "Select To Craft [Multi]:",
        Search = true,
        Multi = true,
        Required = false,
        Options = v160,
        Default = {
            "None"
        },
        Callback = function(p496)
            getgenv().WantedEvoItems = {}
            local v497, v498, v499 = pairs(p496)
            while true do
                v499 = v497(v498, v499)
                if v499 == nil then
                    break
                end
                table.insert(getgenv().WantedEvoItems, v499)
            end
        end
    }, "multiitemevoDP")
    vu48.MainSection19:Toggle({
        Name = "Auto Craft Selected Items",
        Default = false,
        Callback = function(p500)
            getgenv().AutoCraft = p500
            getgenv().DestroySystemMsg = p500
            local vu501 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
            local vu502 = nil
            local function vu504()
                if getgenv().DestroySystemMsg then
                    if not (vu502 and vu502.Connected) then
                        vu502 = vu501.ChildAdded:Connect(function(p503)
                            if p503.Name == "SystemMessage" then
                                p503:Destroy()
                            end
                        end)
                    end
                elseif vu502 then
                    vu502:Disconnect()
                    vu502 = nil
                end
            end
            task.spawn(function()
                while true do
                    vu504()
                    task.wait(0.5)
                end
            end)
            local v505 = vu501
            while getgenv().AutoCraft do
                local v506, v507, v508 = pairs(getgenv().WantedEvoItems)
                while true do
                    local v509
                    v508, v509 = v506(v507, v508)
                    if v508 == nil then
                        break
                    end
                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Crafting"):WaitForChild("Event"):FireServer(v509, "1", "1")
                    task.wait(0.5)
                    local v510 = v505:FindFirstChild("SystemMessage")
                    if v510 and getgenv().DestroySystemMsg then
                        v510:Destroy()
                    end
                end
                task.wait(0.5)
            end
        end
    }, "AutoCraftToggle")
    vu48.MainSection19:Label({
        Text = "You can auto craft in match!"
    })
    vu48.MainSection22:Header({
        Name = "Enable/Disable UI [In-Match]:"
    })
    vu48.MainSection22:Dropdown({
        Name = "Select UI",
        Search = true,
        Multi = false,
        Required = false,
        Options = {
            "Crafting",
            "EvolveTier",
            "FeedEXP",
            "Items",
            "LimitBreaks",
            "Merchant",
            "ShinyNormalize",
            "StatsPotential",
            "Traits",
            "UnitsEvolve",
            "UnitsGacha",
            "ApplyCurse"
        },
        Default = 1,
        Callback = function(p511)
            getgenv().UI = p511
        end
    }, "UIDP")
    vu48.MainSection22:Toggle({
        Name = "Enable/Disable Selected UI",
        Default = false,
        Callback = function(p512)
            game:GetService("Players").LocalPlayer.PlayerGui[getgenv().UI].Enabled = p512
        end
    }, "EnableUI")
    vu48.MainSection20:Header({
        Name = "Auto Buy Items [Merchant]:"
    })
    vu48.MainSection20:Dropdown({
        Name = "Select Multi Items:",
        Search = true,
        Multi = true,
        Required = false,
        Options = {
            "Onigiri",
            "Sunrise Earrings",
            "Blood Ember",
            "Cursed Core",
            "Dark Essence",
            "Demon Fang Shard",
            "Moonroot Herb",
            "Flame Seal Tag",
            "Mirror Lens",
            "Soul Core",
            "Slayer Stone Fragment",
            "Stats Key",
            "Perfect Stats Key",
            "Cursed Finger",
            "Dr. Megga Punk",
            "Trait Reroll",
            "Ranger Crystal",
            "Luck Potion",
            "Green Bean",
            "Narmekian Ore",
            "Power Core",
            "Dracoscale Shard",
            "Arcane Dust",
            "Narmekian Crystal",
            "Nano Fiber Wire",
            "Micro Circuit Board",
            "Phantom Alloy",
            "Enhanced Optical Lens",
            "Energy Vial",
            "Ramen",
            "Storm Flake Crystal",
            "Shadow Fiber",
            "Seal of Gale",
            "Chakra Shard",
            "Ancient Talisman",
            "Smoke Orb",
            "Scroll of Focus",
            "Kunai Shards",
            "Core of Silence",
            "French Fries",
            "Alpha Dust",
            "Blast Cell",
            "Chaos Bone Shard",
            "Surge Nucleus",
            "Mutant Core Fragment",
            "Genesis Matrix",
            "Neurochip Beta",
            "Tactical Frame",
            "SYN-Core",
            "Rubber Fruit",
            "Sea Gem Fragment",
            "Soul Shard",
            "Mystic Kelp",
            "Will Core",
            "Void Pearl",
            "Obsidian Plate",
            "Marine Tech Chip",
            "Combat Fluid",
            "Ghost Lens",
            "Ancient Power Core"
        },
        Default = {
            "None"
        },
        Callback = function(p513)
            getgenv().WantedUnitForEvo = {}
            local v514, v515, v516 = pairs(p513)
            while true do
                v516 = v514(v515, v516)
                if v516 == nil then
                    break
                end
                table.insert(getgenv().WantedUnitForEvo, v516)
            end
        end
    }, "multiunitevoDP")
    vu48.MainSection20:Toggle({
        Name = "Auto Buy Selected Items",
        Default = false,
        Callback = function(p517)
            getgenv().AutoEvo = p517
            local v518 = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Gameplay"):WaitForChild("Merchant")
            while getgenv().AutoEvo do
                local v519, v520, v521 = pairs(WantedUnitForEvo)
                while true do
                    local v522
                    v521, v522 = v519(v520, v521)
                    if v521 == nil then
                        break
                    end
                    v518:FireServer(v522, 1)
                end
                task.wait(0.5)
            end
        end
    }, "AutoEvoToggle")
    vu48.MainSection20:Label({
        Text = "You can auto buy items in match!"
    })
    local v523, v524, v525 = pairs(game:GetService("ReplicatedStorage").Modules.UI.RarityColor.StatsPotential:GetChildren())
    local v526 = {}
    while true do
        local v527
        v525, v527 = v523(v524, v525)
        if v525 == nil then
            break
        end
        table.insert(v526, v527.Name)
    end
    local v528, v529, v530 = pairs(game:GetService("Players").LocalPlayer.PlayerGui.UnitsLoadout.Main:GetChildren())
    local v531 = {}
    while true do
        local v532
        v530, v532 = v528(v529, v530)
        if v530 == nil then
            break
        end
        if v532:IsA("TextButton") then
            table.insert(v531, v532.Name)
        end
    end
    local v533, v534, v535 = pairs(game:GetService("Players").LocalPlayer.PlayerGui.StatsPotential.Main.Base.Grade:GetChildren())
    local v536 = {}
    while true do
        local v537
        v535, v537 = v533(v534, v535)
        if v535 == nil then
            break
        end
        if v537:IsA("Frame") then
            table.insert(v536, v537.Name)
        end
    end
    vu48.MainSection25:Header({
        Name = "Auto Roll Unit Stats:"
    })
    vu48.MainSection25:Dropdown({
        Name = "Select Multi Stats:",
        Search = true,
        Multi = true,
        Required = false,
        Options = v526,
        Default = {
            "None"
        },
        Callback = function(p538)
            getgenv().WantedStatForRoll = {}
            local v539, v540, v541 = pairs(p538)
            while true do
                v541 = v539(v540, v541)
                if v541 == nil then
                    break
                end
                table.insert(getgenv().WantedStatForRoll, v541)
            end
        end
    }, "multistatdp")
    vu48.MainSection25:Dropdown({
        Name = "Select Units [Loadout:]",
        Search = true,
        Multi = false,
        Required = false,
        Options = v531,
        Default = "None",
        Callback = function(p542)
            getgenv().UnitLoadout = p542
        end
    }, "Unitloadoutdp")
    vu48.MainSection25:Dropdown({
        Name = "Select Stat To Roll:",
        Search = true,
        Multi = false,
        Required = false,
        Options = v536,
        Default = "None",
        Callback = function(p543)
            getgenv().StatToRoll = p543
        end
    }, "Unitloadoutdp")
    vu48.MainSection25:Toggle({
        Name = "Auto Roll Selected Stats",
        Default = false,
        Callback = function(p544)
            getgenv().AutoRollStats = p544
            while task.wait(1) do
                if AutoRollStats ~= true then
                    wait()
                    break
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.StatsPotential.Enabled == false then
                    vu26:Dialog({
                        Title = "ПОТУЖНИЙ ЧIТ notify",
                        Description = "you need to open StatsPotential UI and select unit u want first then turn on this function again.",
                        Buttons = {
                            {
                                Name = "Bet daddy kazoun~",
                                Callback = function()
                                end
                            }
                        }
                    })
                    return
                end
                if not (function(p545, p546)
                    local v547, v548, v549 = ipairs(p546)
                    while true do
                        local v550
                        v549, v550 = v547(v548, v549)
                        if v549 == nil then
                            break
                        end
                        if v550 == p545 then
                            return true
                        end
                    end
                    return false
                end)(game:GetService("Players").LocalPlayer.PlayerGui.StatsPotential.Main.Base.Grade[getgenv().StatToRoll].Grade.Text, WantedStatForRoll) then
                    print("not correct stats, start rolling")
                    local v551 = {
                        getgenv().StatToRoll,
                        game:GetService("Players").LocalPlayer.PlayerGui.UnitsLoadout.Main[getgenv().UnitLoadout]:GetAttribute("OnTemplateUnit"),
                        "Selective"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Server"):WaitForChild("Gambling"):WaitForChild("RerollPotential"):FireServer(unpack(v551))
                end
            end
        end
    }, "AutoRollStatsToggle")
    vu48.MainSection25:Paragraph({
        Header = "Note:",
        Body = "You need to open StatPotential UI and select unit from your loadout FIRST before use the function."
    })
    vu48.MainSection13:Header({
        Name = "Misc:"
    })
    vu48.MainSection13:Toggle({
        Name = "Auto Hide UI When Executed",
        Default = false,
        Callback = function(p552)
            getgenv().HideGUI = p552
            if p552 then
                task.spawn(function()
                    task.wait(5)
                    if getgenv().HideGUI then
                        vu26:SetState(false)
                    end
                end)
            end
        end
    }, "AutoHideUI")
    local vu553 = game:GetService("RunService")
    vu48.MainSection13:Toggle({
        Name = "Auto Save GPU [Less Lag]",
        Default = false,
        Callback = function(p554)
            getgenv().AutoSaveGPU = p554
            vu553:Set3dRenderingEnabled(not p554)
        end
    }, "AutoSaveGPUToggle")
    vu48.MainSection13:Toggle({
        Name = "Auto Hide Player Info [Visual]",
        Default = false,
        Callback = function(p555)
            getgenv().HideName = p555
            local vu556 = game.Players.LocalPlayer.Character.Head:WaitForChild("PlayerHeadGui")
            local vu557 = {}
            if p555 then
                local v558, v559, v560 = pairs(vu556:GetDescendants())
                while true do
                    local v561
                    v560, v561 = v558(v559, v560)
                    if v560 == nil then
                        break
                    end
                    if v561:IsA("TextLabel") then
                        vu557[v561] = {
                            Text = v561.Text,
                            Color = v561.TextColor3
                        }
                    end
                end
                task.spawn(function()
                    local v562 = {
                        "DatNguyenOnTop",
                        "ПОТУЖНИЙ ЧIТ comeback!",
                        "NTR_Hentai.com",
                        "kazoun owned you",
                        "Pornhub.com",
                        "furryloverhentai.com"
                    }
                    while task.wait(1) and getgenv().HideName do
                        local v563 = v562[math.random(1, # v562)]
                        local v564 = vu556
                        local v565, v566, v567 = pairs(v564:GetDescendants())
                        while true do
                            local v568
                            v567, v568 = v565(v566, v567)
                            if v567 == nil then
                                break
                            end
                            if v568:IsA("TextLabel") then
                                v568.TextColor3 = Color3.new(math.random(), math.random(), math.random())
                                v568.Text = v563
                            end
                        end
                    end
                    local v569, v570, v571 = pairs(vu557)
                    while true do
                        local v572
                        v571, v572 = v569(v570, v571)
                        if v571 == nil then
                            break
                        end
                        if v571 and v571:IsA("TextLabel") then
                            v571.Text = v572.Text
                            v571.TextColor3 = v572.Color
                        end
                    end
                end)
            end
        end
    }, "AutoHideNameToggle")
    vu48.MainSection13:Toggle({
        Name = "TP Lobby If Glitched",
        Default = false,
        Callback = function(p573)
            getgenv().HPCheckToggle = p573
            if p573 then
                task.spawn(function()
                    local v574 = workspace.Building.For_Use.Base.Red:WaitForChild("BaseHealthBar").HP.Values
                    while task.wait(0.2) and getgenv().HPCheckToggle do
                        if string.match(v574.Text, "^(%d+)") == "0" then
                            local v575 = tick()
                            while tick() - v575 < 30 and (getgenv().HPCheckToggle and string.match(v574.Text, "^(%d+)") == "0") do
                                task.wait(1)
                            end
                            if getgenv().HPCheckToggle and string.match(v574.Text, "^(%d+)") == "0" then
                                game:GetService("TeleportService"):Teleport(72829404259339, vu208)
                            end
                        end
                    end
                end)
            end
        end
    }, "AutoLobbyIfGlitchedToggle")
    vu48.MainSection13:Slider({
        Name = "UI Scale",
        Default = 1,
        Minimum = 0.3,
        Maximum = 2,
        DisplayMethod = "Tenths",
        Callback = function(p576)
            vu26:SetScale(p576)
        end
    })
    vu48.MainSection13:Button({
        Name = "Remove Auto Load Config",
        Callback = function()
            if delfile then
                delfile("Maclib/settings/autoload.txt")
                vu26:Notify({
                    Title = "ПОТУЖНИЙ ЧIТ notify",
                    Description = "Deleted AutoLoad Config, please rejoin.",
                    Lifetime = 10
                })
            else
                vu26:Notify({
                    Title = "ПОТУЖНИЙ ЧIТ notify",
                    Description = "Your executor not support delfile()...",
                    Lifetime = 10
                })
            end
        end
    })
    vu48.MainSection13:Button({
        Name = "Open/Close UI",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/YOies/HideGUI/refs/heads/main/KazounProjects"))()
        end
    })
    v25:SetFolder("Maclib")
    v47.Settings:InsertConfigSection("Left")
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Notification") then
        game:GetService("Players").LocalPlayer.PlayerGui.Notification:Destroy()
    end
    v47.Main:Select()
    v25:LoadAutoLoadConfig()
-- end  -- Временно отключена проверка PlaceId