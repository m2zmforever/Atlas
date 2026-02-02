--       db      mm   `7MM                       `7MMF'        db *MM        
--      ;MM:     MM     MM                         MM              MM        
--     ,V^MM.  mmMMmm   MM   ,6"Yb.  ,pP"Ybd       MM        `7MM  MM,dMMb.  
--    ,M  `MM    MM     MM  8)   MM  8I   `"       MM          MM  MM    `Mb 
--    AbmmmqMA   MM     MM   ,pm9MM  `YMMMa.       MM      ,   MM  MM     M8 
--   A'     VML  MM     MM  8M   MM  L.   I8       MM     ,M   MM  MM.   ,M9 
-- .AMA.   .AMMA.`Mbmo.JMML.`Moo9^Yo.M9mmmP'     .JMMmmmmMMM .JMML.P^YbmdP'  
--
-- Developed by m2_zm                                                                                                                                      

local TweenService = game:GetService("TweenService")
local InputService = game:GetService("UserInputService")

local AtlasLib = {
	["Theme"] = {
	        ["Font"] = "RobotoMono",
		["AccentColor"] = Color3.fromRGB(26, 26, 26),
		["FontColor"] = Color3.fromRGB(255,255,255),
		["HideKey"] = "LeftControl"
	}
}

local CreateModule = {
    reg = {}
}

local function AddToReg(Instance)
    table.insert(CreateModule["reg"],Instance)
end

function CreateModule.Instance(instance,properties)
    local CreatedInstance

    if typeof(instance) == "string" then
        CreatedInstance = Instance.new(instance)
        
        for property,value in next,properties do
            CreatedInstance[property] = value
        end
    end
    return CreatedInstance;
end

local function Darker(Col,coe)
    local H,S,V = Color3.toHSV(Col)
    return Color3.fromHSV(H,S,V / (coe or 1.5));
end

local function Brighter(Col,coe)
    local H,S,V = Color3.toHSV(Col)
    return Color3.fromHSV(H,S,V * (coe or 1.5));
end

local function getEnumMember(enumType, memberName)
    local ok, res = pcall(function() return enumType[memberName] end)
    if ok then return res end
    return nil
end

function AtlasLib.Main(Name,X,Y)

	for i,v in next,game.CoreGui:GetChildren() do
		if v.Name == "AtlasLib" then
			v:Destroy()
		end
	end

    AtlasLib.ScreenGui = CreateModule.Instance("ScreenGui",{
        Name = "AtlasLib";
        Parent = game.CoreGui;
    })

    local LoadingScreen = CreateModule.Instance("Frame",{
        Name = "LoadingScreen";
        Parent = AtlasLib.ScreenGui;
        BackgroundColor3 = Darker(Color3.fromRGB(30,30,35),1.15);
        BackgroundTransparency = 0;
        BorderSizePixel = 0;
        Position = UDim2.new(0.5,0,0.5,0);
        Size = UDim2.new(0,250,0,100);
        AnchorPoint = Vector2.new(0.5,0.5);
        ZIndex = 100;
    })

    local LoadingCorner = CreateModule.Instance("UICorner",{
        Parent = LoadingScreen;
        Name = "Corner";
        CornerRadius = UDim.new(0,8);
    })

    local LoadingStroke = CreateModule.Instance("UIStroke",{
        Parent = LoadingScreen;
        Name = "Stroke";
        Thickness = 2;
        Color = AtlasLib["Theme"]["AccentColor"];
        Transparency = 0;
    })

    local LoadingTitle = CreateModule.Instance("ImageLabel",{
        Parent = LoadingScreen;
        Name = "Title";
        BackgroundTransparency = 1;
        Image = "rbxassetid://71331193428603";
        ImageTransparency = 0;
        ScaleType = Enum.ScaleType.Fit;
        AnchorPoint = Vector2.new(0.5, 0);
        Position = UDim2.new(0.5, 0, 0.08, 0);
        Size = UDim2.new(0,64,0,64);
        ZIndex = 101;
        Visible = true;
    })

    local LoadingStatus = CreateModule.Instance("TextLabel",{
        Parent = LoadingScreen;
        Name = "Status";
        BackgroundTransparency = 1;
        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
        Text = "Loading Modules...";
        TextSize = 12;
        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
        Position = UDim2.new(0,0,0.75,0);
        Size = UDim2.new(1,0,0.2,0);
        ZIndex = 101;
    })
    wait(0.2)
    LoadingStatus.Text = "Loading Modules..."
    wait(0.5)
    LoadingStatus.Text = "Loading UI Library..."
    wait(0.5)
    LoadingStatus.Text = "Applying Theme..."
    wait(0.45)
    LoadingStatus.Text = "Finalizing..."
    wait(0.45)

    TweenService:Create(LoadingScreen, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
    TweenService:Create(LoadingTitle, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
    TweenService:Create(LoadingStatus, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    wait(0.35)
    LoadingScreen:Destroy()

    local Load = CreateModule.Instance("Frame",{
        Name = "LoadFrame";
        Parent = AtlasLib.ScreenGui;
		BackgroundColor3 = Color3.fromRGB(30,30,35);
        BackgroundTransparency = 1;
		BorderSizePixel = 0;
		Position = UDim2.new(0.3,0,0.25,0);
        ZIndex = 5;
	})

    local LoadCorner = CreateModule.Instance("UICorner",{
        Parent = Load;
        Name = "Corner";
        CornerRadius = UDim.new(0,5);
    })

    local Topbar = CreateModule.Instance("Frame",{
        Name = "Topbar";
        Parent = AtlasLib.ScreenGui;
		BackgroundColor3 = Darker(Color3.fromRGB(30,30,35),1.15);
		BorderSizePixel = 0;
		Position = UDim2.new(0.3,0,0.25,0);
		Size = UDim2.new(0,X,0,30);
        Active = true;
        Draggable = true;
        Visible = false;
        ZIndex = 3;
	})

    local Corner = CreateModule.Instance("UICorner",{
        Parent = Topbar;
        Name = "Corner";
        CornerRadius = UDim.new(0,5);
    })

    Topbar.Changed:Connect(function(Property)
        if Property == "Position" then
            Load.Position = Topbar.Position
        end
    end)


    local Icon = CreateModule.Instance("ImageLabel",{
        Parent = Topbar;
        Name = "Icon";
        BackgroundTransparency = 1;
        Image = "rbxassetid://71331193428603";
        Size = UDim2.new(0,24,0,24);
        Position = UDim2.new(0,8,0.5,0);
        AnchorPoint = Vector2.new(0,0.5);
        ZIndex = 3;
    })

    local NameLabel = CreateModule.Instance("TextLabel",{
        Parent = Topbar;
        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
        Text = Name;
        TextSize = 16;
        TextColor3 = AtlasLib["Theme"]["FontColor"];
        TextXAlignment = Enum.TextXAlignment.Left;
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(0,46,0,0);
        Size = UDim2.new(0,100,1,0);
        ZIndex = 3;
    })

	local Container = CreateModule.Instance("Frame",{
		Parent = Topbar;
		Name = "Container";
		BackgroundColor3 = Color3.fromRGB(30,30,33);
		BorderSizePixel = 0;
		Position = UDim2.new(0,0,1,-5);
		Size = UDim2.new(1,0,0,Y);
        ClipsDescendants = true;
	})

    local Border = CreateModule.Instance("Frame",{
		Name = "Border";
		Parent = Topbar;
		BackgroundColor3 = Color3.fromRGB(30,30,35);
        BackgroundTransparency = 0.99;
		BorderSizePixel = 0;
		Position = UDim2.new(0,0,0,0);
        ZIndex = 5;
	})

    local StrokeBorder = CreateModule.Instance("UIStroke",{
        Parent = Border;
        Name = "Stroke";
        Thickness = 1;
        Color = AtlasLib["Theme"]["AccentColor"];
        Transparency = 0.5;
    })

    local CornerBorder = CreateModule.Instance("UICorner",{
        Parent = Border;
        Name = "Corner";
        CornerRadius = UDim.new(0,5);
    })

    Load.Size = UDim2.new(0,Topbar.Size.X.Offset,0,Topbar.Size.Y.Offset + Container.Size.Y.Offset -5);
    Border.Size = UDim2.new(0,Topbar.Size.X.Offset,0,Topbar.Size.Y.Offset + Container.Size.Y.Offset -5);
    spawn(function()
        wait(0.2)
        TweenService:Create(Load,TweenInfo.new(0.3),{BackgroundTransparency = 0}):Play()
        wait(0.45)
        TweenService:Create(Load,TweenInfo.new(0.3),{BackgroundTransparency = 1}):Play()
        Topbar.Visible = true
    end)
    local Corner = CreateModule.Instance("UICorner",{
        Parent = Container;
        Name = "Corner";
        CornerRadius = UDim.new(0,5);
    })

    local Pages = CreateModule.Instance("Frame",{
		Parent = Container;
		Name = "Tabs";
        BackgroundTransparency = 1;
		BorderSizePixel = 0;
		Position = UDim2.new(0,0,0,0);
		Size = UDim2.new(1,0,1,0);
	})

    local PageLayout = CreateModule.Instance("UIPageLayout",{
        Parent = Pages;
        Name = "PagesLayout";
        Padding = UDim.new(0,10);
        TweenTime = 0;
        EasingDirection = Enum.EasingDirection.Out;
        EasingStyle = Enum.EasingStyle.Sine;
        FillDirection = Enum.FillDirection.Vertical;
        HorizontalAlignment = Enum.HorizontalAlignment.Center;
    })


    local TabsButtons = CreateModule.Instance("Frame",{
        Parent = Topbar;
        Name = "TabsButtons";
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(0.18,0,0,0);
        Size = UDim2.new(0.82,0,1,0);
        ZIndex = 3;
    })


    local ButtonsList = CreateModule.Instance("UIListLayout",{
        Parent = TabsButtons;
        FillDirection = Enum.FillDirection.Horizontal;
        SortOrder = Enum.SortOrder.LayoutOrder;
		Padding = UDim.new(0,4)
    })

    local TabButtonsList = {}
    local CurrentTabPage = 1
    local TabsPerPage = 6

    local PrevArrow = CreateModule.Instance("TextButton",{
        Parent = Topbar;
        Name = "PrevArrow";
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(TabsButtons.Position.X.Scale, -18, 0.5, 0);
        AnchorPoint = Vector2.new(0.5,0.5);
        Size = UDim2.new(0,24,0,24);
        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
        Text = "<";
        TextSize = 20;
        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
        ZIndex = 4;
    })

    local NextArrow = CreateModule.Instance("TextButton",{
        Parent = Topbar;
        Name = "NextArrow";
        BackgroundTransparency = 1;
        BorderSizePixel = 0;
        Position = UDim2.new(TabsButtons.Position.X.Scale + TabsButtons.Size.X.Scale, -18, 0.5, 0);
        AnchorPoint = Vector2.new(0.5,0.5);
        Size = UDim2.new(0,24,0,24);
        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
        Text = ">";
        TextSize = 20;
        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
        ZIndex = 4;
    })

    local function UpdateTabPages()
        local totalPages = math.max(1, math.ceil(#TabButtonsList / TabsPerPage))
        if CurrentTabPage > totalPages then CurrentTabPage = totalPages end
        for i, btn in ipairs(TabButtonsList) do
            local pageIndex = math.ceil(i / TabsPerPage)
            btn.Visible = (pageIndex == CurrentTabPage)
        end
        PrevArrow.Visible = (CurrentTabPage > 1)
        NextArrow.Visible = (CurrentTabPage < totalPages)
    end

    PrevArrow.MouseButton1Click:Connect(function()
        if CurrentTabPage > 1 then
            CurrentTabPage = CurrentTabPage - 1
            UpdateTabPages()
        end
    end)

    NextArrow.MouseButton1Click:Connect(function()
        local totalPages = math.max(1, math.ceil(#TabButtonsList / TabsPerPage))
        if CurrentTabPage < totalPages then
            CurrentTabPage = CurrentTabPage + 1
            UpdateTabPages()
        end
    end)

    local IsGuiOpened = true

    InputService.InputBegan:Connect(function(input,IsTyping)
        if IsTyping then return end
        local keyName = AtlasLib["Theme"]["HideKey"]
        local keyEnum = getEnumMember(Enum.KeyCode, keyName)
        local uitEnum = getEnumMember(Enum.UserInputType, keyName)
        if (keyEnum and input.KeyCode == keyEnum) or (uitEnum and input.UserInputType == uitEnum) then
            spawn(function()
                TweenService:Create(Load,TweenInfo.new(0.15),{BackgroundTransparency = 0}):Play()
                wait(0.2)
                TweenService:Create(Load,TweenInfo.new(0.3),{BackgroundTransparency = 1}):Play()
                Topbar.Visible = not Topbar.Visible
            end)
        end
    end)

	local InMain = {}
    local TabCount = 0


    local ActiveNotifications = {}
    local NotificationOffset = 0.12
    
    function InMain.Notification(HeaderText,Text)
        local yOffset = 0.8 - (NotificationOffset * #ActiveNotifications)
        
        local Bar = CreateModule.Instance("Frame",{
            Parent = AtlasLib.ScreenGui;
            Name = HeaderText;
            BackgroundColor3 = Color3.fromRGB(30,30,33);
            BorderSizePixel = 0;
            Position = UDim2.new(1,20,yOffset,0);
            Size = UDim2.new(0.2,0,0.12,0);
            ClipsDescendants = true;
            BackgroundTransparency = 1;
            ZIndex = 10 + #ActiveNotifications;
        })

        local Corner = CreateModule.Instance("UICorner",{
            Parent = Bar;
            Name = "Corner";
            CornerRadius = UDim.new(0,8);
        })

        local Stroke = CreateModule.Instance("UIStroke",{
            Parent = Bar;
            Name = "Stroke";
            Thickness = 1;
            Color = AtlasLib["Theme"]["AccentColor"];
            Transparency = 0.5;
        })

        local HeaderLabel = CreateModule.Instance("TextLabel",{
            Parent = Bar;
            Font = Enum.Font[AtlasLib["Theme"]["Font"]];
            Text = HeaderText;
            TextSize = 18;
            TextColor3 = Color3.fromRGB(255, 255, 255);
            TextXAlignment = Enum.TextXAlignment.Left;
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.05,0,0.05,0);
            Size = UDim2.new(0.9,0,0.25,0);
            ZIndex = 11 + #ActiveNotifications;
        })

        local InformationLabel = CreateModule.Instance("TextLabel",{
            Parent = Bar;
            Font = Enum.Font[AtlasLib["Theme"]["Font"]];
            Text = Text;
            TextSize = 14;
            TextColor3 = AtlasLib["Theme"]["FontColor"];
            TextXAlignment = Enum.TextXAlignment.Left;
            TextYAlignment = Enum.TextYAlignment.Top;
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.05,0,0.35,0);
            Size = UDim2.new(0.9,0,0.6,0);
            TextWrapped = true;
            ZIndex = 11 + #ActiveNotifications;
        })

        table.insert(ActiveNotifications, Bar)

        spawn(function()
            TweenService:Create(Bar, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.78, 0, yOffset, 0),
                BackgroundTransparency = 0
            }):Play()
            
            TweenService:Create(Stroke, TweenInfo.new(0.5), {
                Transparency = 0
            }):Play()

            wait(4)

            TweenService:Create(Bar, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 20, yOffset, 0),
                BackgroundTransparency = 1
            }):Play()
            
            TweenService:Create(Stroke, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play()

            wait(0.5)
            
            for i, notification in ipairs(ActiveNotifications) do
                if notification == Bar then
                    table.reMove(ActiveNotifications, i)
                    break
                end
            end
            
            Bar:Destroy()
        end)
    end

    InMain.Nofitication = InMain.Notification

	function InMain.Tab(Text)
        TabCount += 1

		local TabButton = CreateModule.Instance("TextButton",{
			Parent = TabsButtons;
			Name = "TabsButtons";
            BackgroundTransparency = 1;
			BorderSizePixel = 0;
			Position = UDim2.new(0,0,0,0);
			Size = UDim2.new(0.15,0,1,0);
			Font = Enum.Font[AtlasLib["Theme"]["Font"]];
			Text = Text;
			TextSize = 15;
			TextXAlignment = Enum.TextXAlignment.Center;
			AutoButtonColor = false;
            AutomaticSize = Enum.AutomaticSize.X;
            ZIndex = 3;
		})

        local IsTabActive = CreateModule.Instance("BoolValue",{
            Parent = TabButton;
            Name = "IsActive";
            Value = (TabCount == 1 and true or TabCount ~= 1 and false)
        })

        TabButton.TextColor3 = (IsTabActive.Value and AtlasLib["Theme"]["FontColor"] or not IsTabActive.Value and Darker(AtlasLib["Theme"]["FontColor"],2))


		TabButton.MouseEnter:Connect(function()
            if IsTabActive.Value then
                TweenService:Create(TabButton,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
            else
                TweenService:Create(TabButton,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5)}):Play()
            end
		end)

		TabButton.MouseLeave:Connect(function()
            if not IsTabActive.Value then
			    TweenService:Create(TabButton,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],2)}):Play()
            else
                TweenService:Create(TabButton,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.2)}):Play()
            end
		end)



        local Page = CreateModule.Instance("ScrollingFrame",{
            Parent = Pages;
            Name = Text;
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(0.95,0,1,0);
            CanvasSize = UDim2.new(0,0,0,0);
            AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollBarThickness = 0;
            ScrollBarImageTransparency = 1;
        })

        local PageList = CreateModule.Instance("Frame",{
            Parent = Page;
            Name = "PageList";
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.015,0,0.015,0);
            Size = UDim2.new(0.5,0,1,0);
        })

        local PageList2 = CreateModule.Instance("Frame",{
            Parent = Page;
            Name = "PageList2";
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0.52,0,0.015,0);
            Size = UDim2.new(0.5,0,1,0);
        })

        local ElementsList = CreateModule.Instance("UIListLayout",{
            Parent = PageList;
            Padding = UDim.new(0,15);
            HorizontalAlignment = Enum.HorizontalAlignment.Left;
            SortOrder = Enum.SortOrder.LayoutOrder;
        })

        local ElementsList2 = CreateModule.Instance("UIListLayout",{
            Parent = PageList2;
            Padding = UDim.new(0,15);
            HorizontalAlignment = Enum.HorizontalAlignment.Left;
            SortOrder = Enum.SortOrder.LayoutOrder;
        })

        local Fader = CreateModule.Instance("Frame",{
            Parent = Page;
            Name = 'Fader';
            BackgroundColor3 = Color3.fromRGB(30,30,33);
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(1,0,1,0);
            ZIndex = 2;
        })

        local ign = CreateModule.Instance("Frame",{
            Parent = PageList;
            Name = 'ign';
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(0,0,0,0);
            LayoutOrder = -99;
        })

        local ign2 = CreateModule.Instance("Frame",{
            Parent = PageList;
            Name = 'ign';
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(0,0,0,5);
            LayoutOrder = 999;
        })

        local ign3 = CreateModule.Instance("Frame",{
            Parent = PageList2;
            Name = 'ign';
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(0,0,0,0);
            LayoutOrder = -99;
        })

        local ign4 = CreateModule.Instance("Frame",{
            Parent = PageList2;
            Name = 'ign';
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = UDim2.new(0,0,0,0);
            Size = UDim2.new(0,0,0,5);
            LayoutOrder = 999;
        })

        TabButton.MouseButton1Click:Connect(function()
            for i,v in next,Pages:GetChildren() do
                if v.Name ~= Text and v:FindFirstChild("Fader") then
                    TweenService:Create(v.Fader,TweenInfo.new(0.3),{BackgroundTransparency = 0}):Play()
                    spawn(function()
                        wait(0.32)
                        PageLayout:JumpTo(Page)
                        TweenService:Create(Fader,TweenInfo.new(0.3),{BackgroundTransparency = 1}):Play()
                    end)
                end
            end

            for i,v in next,TabsButtons:GetChildren() do
                if v.ClassName == "TextButton" and v.Name ~= Text then
                    v.IsActive.Value = false
                    TweenService:Create(v,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],2)}):Play()
                end
            end
            IsTabActive.Value = true
            TweenService:Create(TabButton,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
        end)

        if TabCount == 1 then
            PageLayout:JumpTo(Page)
            TweenService:Create(Fader,TweenInfo.new(0.3),{BackgroundTransparency = 1}):Play()
        end
        table.insert(TabButtonsList, TabButton)
        UpdateTabPages()
        local InPage = {}

        function InPage.Section(Text)
            local InSection = {}

            local Column = PageList
            if ElementsList.AbsoluteContentSize.Y > ElementsList2.AbsoluteContentSize.Y then
                Column = PageList2
            end

            local Section = CreateModule.Instance("Frame",{
                Parent = Column;
                Name = Text;
                BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                BorderSizePixel = 0;
                BorderColor3 = Brighter(Color3.fromRGB(32,32,37),1.5);
                Position = UDim2.new(0,0,0,0);
                Size = UDim2.new(0.95,0,0,30);
                AutomaticSize = Enum.AutomaticSize.Y;
            })

            local Corner = CreateModule.Instance("UICorner",{
                Parent = Section;
                Name = "Corner";
                CornerRadius = UDim.new(0,5);
            })

            local Stroke = CreateModule.Instance("UIStroke",{
                Parent = Section;
                Name = "Stroke";
                Thickness = 1;
                Color = Color3.fromRGB(40,40,40);
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            })

            local SectionLabel = CreateModule.Instance("TextLabel",{
                Parent = Section;
                Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                Text = Text;
                TextSize = 16;
                TextColor3 = AtlasLib["Theme"]["FontColor"];
                TextXAlignment = Enum.TextXAlignment.Left;
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = UDim2.new(0,5,0,1);
                Size = UDim2.new(1,0,0,20);
            })

            
            local SectionElements = CreateModule.Instance("Frame",{
                Parent = Section;
                Name = Text;
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = UDim2.new(0,0,0,0);
                Size = UDim2.new(1,0,1,0);
            })

            local SectionList = CreateModule.Instance("UIListLayout",{
                Parent = SectionElements;
                Padding = UDim.new(0,5);
                HorizontalAlignment = Enum.HorizontalAlignment.Center;
                SortOrder = Enum.SortOrder.LayoutOrder;
            })

            local ign = CreateModule.Instance("Frame",{
                Parent = SectionElements;
                Name = 'ign';
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = UDim2.new(0,0,0,0);
                Size = UDim2.new(0,0,0,20);
                LayoutOrder = -999;
            })

            local ign2 = CreateModule.Instance("Frame",{
                Parent = SectionElements;
                Name = 'ign';
                BackgroundTransparency = 1;
                BorderSizePixel = 0;
                Position = UDim2.new(0,0,0,0);
                Size = UDim2.new(0,0,0,0);
                LayoutOrder = 999;
            })

            function InSection.Button(Text,func)
                local Button = CreateModule.Instance("TextButton",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 1;
                    BorderColor3 = Color3.fromRGB(40,40,40);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = Text;
                    TextSize = 16;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Center;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    AutoButtonColor = false;
                })


                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Button;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Button;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
                    TweenService:Create(Button,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(32,32,37)}):Play()
                end)
        
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5)}):Play()
                    TweenService:Create(Button,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15)}):Play()
                end)
                Button.MouseButton1Click:Connect(function()
                    pcall(func)
                end)
                AddToReg(Button)
                return Button;
            end
            function InSection.KeyBind(Text,func,defkey)
                local Keybind = CreateModule.Instance("TextLabel",{
                    Parent = SectionElements;
                    Name = Text or "Keybind";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,25);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = "";
                    TextSize = 16;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Left;
                })

                local Label = CreateModule.Instance("TextLabel",{
                    Parent = Keybind;
                    Name = "Label";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(60,60,60);
                    Position = UDim2.new(0,60,0,0);
                    Size = UDim2.new(1,-50,1,0);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    Text = Text;
                    TextSize = 16;
                    TextXAlignment = Enum.TextXAlignment.Left;
                })

                local function GetKeyDisplayName(keyCode)
                    local keyString = tostring(keyCode):gsub("Enum.KeyCode.", "")
                    local keyMap = {
                        ["LeftControl"] = "LCtrl",
                        ["RightControl"] = "RCtrl",
                        ["LeftShift"] = "LShift",
                        ["RightShift"] = "RShift",
                        ["LeftAlt"] = "LAlt",
                        ["RightAlt"] = "RAlt",
                        ["Space"] = "Space",
                        ["Return"] = "Enter",
                        ["Escape"] = "Esc",
                        ["Tab"] = "Tab",
                        ["CapsLock"] = "Caps",
                        ["Backspace"] = "Back",
                        ["Delete"] = "Del",
                        ["Insert"] = "Ins",
                        ["Home"] = "Home",
                        ["End"] = "End",
                        ["PageUp"] = "PgUp",
                        ["PageDown"] = "PgDn",
                        ["ArrowUp"] = "↑",
                        ["ArrowDown"] = "↓",
                        ["ArrowLeft"] = "←",
                        ["ArrowRight"] = "→",
                        ["NumPad0"] = "Num0",
                        ["NumPad1"] = "Num1",
                        ["NumPad2"] = "Num2",
                        ["NumPad3"] = "Num3",
                        ["NumPad4"] = "Num4",
                        ["NumPad5"] = "Num5",
                        ["NumPad6"] = "Num6",
                        ["NumPad7"] = "Num7",
                        ["NumPad8"] = "Num8",
                        ["NumPad9"] = "Num9",
                        ["NumLock"] = "NumLk",
                        ["Multiply"] = "Num*",
                        ["Add"] = "Num+",
                        ["Subtract"] = "Num-",
                        ["Divide"] = "Num/",
                        ["Decimal"] = "Num.",
                        ["F1"] = "F1",
                        ["F2"] = "F2",
                        ["F3"] = "F3",
                        ["F4"] = "F4",
                        ["F5"] = "F5",
                        ["F6"] = "F6",
                        ["F7"] = "F7",
                        ["F8"] = "F8",
                        ["F9"] = "F9",
                        ["F10"] = "F10",
                        ["F11"] = "F11",
                        ["F12"] = "F12",
                        ["OEM1"] = ";",
                        ["OEMPlus"] = "+",
                        ["OEMMinus"] = "-",
                        ["OEMComma"] = ",",
                        ["OEMPeriod"] = ".",
                        ["OEM2"] = "/",
                        ["OEM3"] = "`",
                        ["OEM4"] = "[",
                        ["OEM5"] = "\\",
                        ["OEM6"] = "]",
                        ["OEM7"] = "'",
                        ["OEM8"] = "§",
                        ["OEM102"] = "<",
                    }
                    return keyMap[keyString] or keyString
                end

                local Keybinder = CreateModule.Instance("TextButton",{
                    Parent = Keybind;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0,0.5);
                    Position = UDim2.new(0,0,0.5,0);
                    Size = UDim2.new(0,50,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = displayKey;
                    TextSize = 16;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Center;
                    AutoButtonColor = false;
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Keybinder;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Keybinder;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                local Picked,Picking = false

                local Key = defkey or nil
                InputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard and Picking then
                        local hideKey = getEnumMember(Enum.KeyCode, AtlasLib["Theme"]["HideKey"])
                        if not (hideKey and input.KeyCode == hideKey) then
                            Key = tostring(input.KeyCode):gsub("Enum.KeyCode.","")
                            Keybinder.Text = GetKeyDisplayName(input.KeyCode)
                            Picked = true
                        end
                    end
                end)

                Keybinder.MouseButton1Click:Connect(function()
                    Picking = true
                    Keybinder.Text = "..."
                    spawn(function()
                        repeat wait() until Picked
                        local kdisp = "..."

                        local kk = getEnumMember(Enum.KeyCode, Key)
                        if kk then kdisp = GetKeyDisplayName(kk) else kdisp = tostring(Key) end
                        Keybinder.Text = kdisp
                        pcall(func, Key)
                        Picking = false
                        Picked = false
                    end)
                end)
                AddToReg(Keybind)
            end
            function InSection.Checkbox(Text,func,defbool)
                local Checkbox = CreateModule.Instance("TextButton",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(60,60,60);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = "";
                    TextSize = 16;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    AutoButtonColor = false;
                })

                local Corner1 = CreateModule.Instance("UICorner",{
                    Parent = Checkbox;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke1 = CreateModule.Instance("UIStroke",{
                    Parent = Checkbox;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                local Label = CreateModule.Instance("TextLabel",{
                    Parent = Checkbox;
                    Name = "Label";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(60,60,60);
                    Position = UDim2.new(0,27,0,0);
                    Size = UDim2.new(1,-25,1,0);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = Text;
                    TextSize = 16;
                    TextXAlignment = Enum.TextXAlignment.Left;
                })

                local IsActive = CreateModule.Instance("BoolValue",{
                    Parent = Checkbox;
                    Name = "IsActive";
                })

                IsActive.Value = defbool or false

                Label.TextColor3 = (IsActive.Value and AtlasLib["Theme"]["FontColor"] or not IsActive.Value and Darker(AtlasLib["Theme"]["FontColor"],1.5))

                local Checked = CreateModule.Instance("Frame",{
                    Parent = Checkbox;
                    Name = 'Cube';
                    BackgroundTransparency = 0;
                    BackgroundColor3 = (IsActive.Value and AtlasLib["Theme"]["AccentColor"] or not IsActive.Value and Darker(Color3.fromRGB(32,32,37),1.15));
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0,0.5);
                    Position = UDim2.new(0,5,0.5,0);
                    Size = UDim2.new(0,15,0,15);
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Checked;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Checked;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                })

                IsActive.Changed:Connect(function()
                    if IsActive.Value then
                        TweenService:Create(Label,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
                        TweenService:Create(Checked,TweenInfo.new(0.3),{BackgroundColor3 = Brighter(AtlasLib["Theme"]["AccentColor"],1.5)}):Play()
                        pcall(func, IsActive.Value)
                    else
                        TweenService:Create(Checked,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15)}):Play()
                        TweenService:Create(Label,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5)}):Play()
                        pcall(func, IsActive.Value)
                    end
                end)

                Checkbox.MouseButton1Click:Connect(function()
                    IsActive.Value = not IsActive.Value
                end)
                AddToReg(Checkbox)
                return Checkbox;
            end
            function InSection.TextLabel(Text)
                local Label = CreateModule.Instance("TextLabel",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = Text;
                    TextSize = 14;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextYAlignment = Enum.TextYAlignment.Center;
                })
                AddToReg(Label)
                return Label;
            end
            function InSection.TextBox(Text,func,defvalue)
                local TextBoxFrame = CreateModule.Instance("Frame",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,25);
                })

                local TextBox = CreateModule.Instance("TextBox",{
                    Parent = TextBoxFrame;
                    Name = "TextBox";
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(1,0,1,0);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = defvalue or "";
                    TextSize = 14;
                    TextColor3 = AtlasLib["Theme"]["FontColor"];
                    TextXAlignment = Enum.TextXAlignment.Left;
                    PlaceholderText = Text;
                    PlaceholderColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    ClearTextOnFocus = false;
                    ClipsDescendants = true;
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = TextBox;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = TextBox;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                TextBox.FocusLost:Connect(function()
                    TweenService:Create(TextBox, TweenInfo.new(0.3), {
                        BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15)
                    }):Play()
                    TweenService:Create(Stroke, TweenInfo.new(0.3), {
                        Color = Color3.fromRGB(40,40,40)
                    }):Play()
                end)

                TextBox.Focused:Connect(function()
                    TweenService:Create(TextBox, TweenInfo.new(0.3), {
                        BackgroundColor3 = Color3.fromRGB(32,32,37)
                    }):Play()
                    TweenService:Create(Stroke, TweenInfo.new(0.3), {
                        Color = AtlasLib["Theme"]["AccentColor"]
                    }):Play()
                end)

                TextBox.FocusLost:Connect(function()
                    pcall(func, TextBox.Text)
                end)

                AddToReg(TextBoxFrame)
                return TextBox;
            end
            function InSection.Slider(Text,min,max,func,precise,defvalue)
                local Slider = CreateModule.Instance("TextLabel",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(60,60,60);
                    Position = UDim2.new(0,22,0,0);
                    Size = UDim2.new(0.95,0,0,40);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    Text = Text;
                    TextSize = 16;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    TextYAlignment = Enum.TextYAlignment.Top;
                })

                local Bar = CreateModule.Instance("Frame",{
                    Parent = Slider;
                    Name = 'Bar';
                    BackgroundTransparency = 0;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0,0.5);
                    Position = UDim2.new(0,0,0.75,0);
                    Size = UDim2.new(1,0,0,20);
                    ClipsDescendants = true;
                })

                local ValueLabel = CreateModule.Instance("TextLabel",{
                    Parent = Bar;
                    Name = "Label";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(60,60,60);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(1,0,1,0);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    Text = tostring(defvalue) .. "/".. max  or tostring(min) .. "/".. max ;
                    TextSize = 16;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    ZIndex = 2;
                })

                local Progress = CreateModule.Instance("Frame",{
                    Parent = Bar;
                    Name = 'Progress';
                    BackgroundTransparency = 0;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.05);
                    BorderSizePixel = 0;
                    AnchorPoint = Vector2.new(0,0.5);
                    Position = UDim2.new(0,0,0.5,0);
                    Size = UDim2.new(0,0,1,0);
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Bar;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Bar;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                })

                local Corner2 = CreateModule.Instance("UICorner",{
                    Parent = Progress;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                

                local Mouse = game.Players.LocalPlayer:GetMouse()

				local function UpdateSlider(val)
					local percent = (val - min) / (max - min)

					percent = math.clamp(percent, 0, 1)

					Progress:TweenSize(UDim2.new(percent, 0, 1, 0),"Out","Sine",1,true)
				end

				UpdateSlider(defvalue)

				local IsSliding,Dragging = false
				local RealValue = defvalue
				local value
				local function Move(Pressed)
					IsSliding = true;
					local pos = UDim2.new(math.clamp((Pressed.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1), 0, 1, 0)
					local size = UDim2.new(math.clamp((Pressed.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1), 0, 1, 0)
					Progress:TweenSize(size, "Out", "Quart", 0.2,true);
					RealValue = (((pos.X.Scale * max) / max) * (max - min) + min)
					value = (precise and string.format("%.1f", tostring(RealValue))) or (math.floor(RealValue))
					ValueLabel.Text = tostring(value) .. "/".. max 
					func(value)
				end

				Bar.InputBegan:Connect(function(Pressed)
					if Pressed.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = true
						IsSliding = false
                        Move(Pressed)
                        TweenService:Create(Progress,TweenInfo.new(0.3),{BackgroundColor3 = Darker(AtlasLib["Theme"]["AccentColor"],1.2)}):Play()
					end
				end)

				Bar.InputEnded:Connect(function(Pressed)
					if Pressed.UserInputType == Enum.UserInputType.MouseButton1 then
						Dragging = false
						IsSliding = false
                        TweenService:Create(Progress,TweenInfo.new(0.3),{BackgroundColor3 = Darker(AtlasLib["Theme"]["AccentColor"],1.7)}):Play()
                        Move(Pressed)
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(Pressed)
					if Dragging and Pressed.UserInputType == Enum.UserInputType.MouseMovement then
                        Move(Pressed)
					end
				end)

				Bar.MouseEnter:Connect(function()
					TweenService:Create(Progress,TweenInfo.new(0.3),{BackgroundColor3 = Darker(AtlasLib["Theme"]["AccentColor"],1.7)}):Play()
				end)

				Bar.MouseLeave:Connect(function()
					if not Dragging then
						TweenService:Create(Progress,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.05)}):Play()
					end
                    if Dragging then
                        spawn(function()
                            repeat wait() until not Dragging
                            TweenService:Create(Progress,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.05)}):Play()
                        end)
                    end
				end)
                AddToReg(Slider)
                return Slider;
            end
            function InSection.Dropdown(Text,Selectables,ind,func)
                local Dropdown = CreateModule.Instance("Frame",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(40,40,40);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,20);
                    ClipsDescendants = true;
                })
                local DropdownButton = CreateModule.Instance("TextButton",{
                    Parent = Dropdown;
                    Name = "DropdownButton";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(40,40,40);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(1,0,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = "  " .. Text;
                    TextSize = 16;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    AutoButtonColor = false;
                })

                local DropdownImage = CreateModule.Instance("ImageLabel",{
                    Parent = DropdownButton;
                    AnchorPoint = Vector2.new(0, 0.5);
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    BackgroundTransparency = 1.000;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0.9, 0, 0.5, 0);
                    Size = UDim2.new(0, 20, 0, 20);
                    Image = "rbxassetid://3926305904";
                    ImageColor3 = Color3.fromRGB(136, 136, 136);
                    ImageRectOffset = Vector2.new(44, 404);
                    ImageRectSize = Vector2.new(36, 36);
                    Rotation = 0;
                })


                local List = CreateModule.Instance("ScrollingFrame",{
                    Parent = Dropdown;
                    Name = 'List';
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,20);
                    Size = UDim2.new(1,0,0,0);
                    CanvasSize = UDim2.new(0,0,0,0);
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    ScrollBarImageTransparency = 1;
                })

                
                local DropdownList = CreateModule.Instance("UIListLayout",{
                    Parent = List;
                    Padding = UDim.new(0,5);
                    HorizontalAlignment = Enum.HorizontalAlignment.Center;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })

                CreateModule.Instance("Frame",{
                    Parent = List;
                    Name = 'ign';
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0,0,0,0);
                    LayoutOrder = -99999;
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Dropdown;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Dropdown;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                local IsOpened = false

                DropdownButton.MouseButton1Click:Connect(function()
                    IsOpened = not IsOpened
                    if IsOpened then
                        Dropdown:TweenSize(UDim2.new(0.95,0,0,120),"Out","Quart",0.3,true)
                        List:TweenSize(UDim2.new(1,0,0,100),"Out","Quart",0.3,true)
                        TweenService:Create(DropdownImage,TweenInfo.new(0.3),{Rotation = 180}):Play()
                    else
                        Dropdown:TweenSize(UDim2.new(0.95,0,0,20),"Out","Quart",0.3,true)
                        List:TweenSize(UDim2.new(1,0,0,0),"Out","Quart",0.3,true)
                        TweenService:Create(DropdownImage,TweenInfo.new(0.3),{Rotation = 0}):Play()
                    end
                end)

                local function NewSelectable(string,value)
                    local Selectable = CreateModule.Instance("TextButton",{
                        Parent = List;
                        Name = string;
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        BorderColor3 = Color3.fromRGB(40,40,40);
                        Position = UDim2.new(0,0,0,0);
                        Size = UDim2.new(0.95,0,0,20);
                        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                        Text = "  " .. string;
                        TextSize = 16;
                        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextYAlignment = Enum.TextYAlignment.Center;
                        AutoButtonColor = false;
                    })

                    local Corner = CreateModule.Instance("UICorner",{
                        Parent = Selectable;
                        Name = "Corner";
                        CornerRadius = UDim.new(0,5);
                    })
    
                    local Stroke = CreateModule.Instance("UIStroke",{
                        Parent = Selectable;
                        Name = "Stroke";
                        Thickness = 1;
                        Color = Color3.fromRGB(40,40,40);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    })

                    Selectable.MouseEnter:Connect(function()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(32,32,37)}):Play()
                    end)
            
                    Selectable.MouseLeave:Connect(function()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5)}):Play()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15)}):Play()
                    end)

                    Selectable.MouseButton1Click:Connect(function()
                        pcall(func, string, value)
                        DropdownButton.Text = "  " .. string
                        Dropdown:TweenSize(UDim2.new(0.95,0,0,20),"Out","Quart",0.3,true)
                        List:TweenSize(UDim2.new(1,0,0,0),"Out","Quart",0.3,true)
                        TweenService:Create(DropdownImage,TweenInfo.new(0.3),{Rotation = 0}):Play()
                        IsOpened = false
                    end)
                end

                for string,value in next,Selectables do
                    if ind == 1 then
                        NewSelectable(tostring(string),tostring(value))
                    elseif ind == 2 then
                        NewSelectable(tostring(value),tostring(string))
                    end
                end
                local InDropdown = {}
                function InDropdown.Refresh(selec)
                    for i,v in next,List:GetChildren() do
                        if v.ClassName == "TextButton" then
                            v:Destroy()
                        end
                    end
                    wait()
                    for string,value in next,selec do
                        if ind == 1 then
                            NewSelectable(tostring(string),tostring(value))
                        elseif ind == 2 then
                            NewSelectable(tostring(value),tostring(string))
                        end
                    end
                end
                function InDropdown.Set(selectionString)
                    if typeof(selectionString) ~= "string" then return end
                    DropdownButton.Text = "  " .. selectionString
                end
                function InDropdown.SetByIndex(idx)
                    local i = 0
                    for k,v in next,Selectables do
                        i = i + 1
                        if i == tonumber(idx) then
                            DropdownButton.Text = "  " .. tostring(v)
                            return
                        end
                    end
                end
                AddToReg(Dropdown)
                return InDropdown;
            end

            function InSection.MultiDropdown(Text,Selectables,ind,func)
                local Dropdown = CreateModule.Instance("Frame",{
                    Parent = SectionElements;
                    Name = Text;
                    BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15);
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(40,40,40);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0.95,0,0,20);
                    ClipsDescendants = true;
                })
                local DropdownButton = CreateModule.Instance("TextButton",{
                    Parent = Dropdown;
                    Name = "DropdownButton";
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BorderColor3 = Color3.fromRGB(40,40,40);
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(1,0,0,20);
                    Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                    Text = "  " .. Text;
                    TextSize = 16;
                    TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextYAlignment = Enum.TextYAlignment.Center;
                    AutoButtonColor = false;
                })

                local DropdownImage = CreateModule.Instance("ImageLabel",{
                    Parent = DropdownButton;
                    AnchorPoint = Vector2.new(0, 0.5);
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    BackgroundTransparency = 1.000;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0.9, 0, 0.5, 0);
                    Size = UDim2.new(0, 20, 0, 20);
                    Image = "rbxassetid://3926305904";
                    ImageColor3 = Color3.fromRGB(136, 136, 136);
                    ImageRectOffset = Vector2.new(44, 404);
                    ImageRectSize = Vector2.new(36, 36);
                    Rotation = 0;
                })


                local List = CreateModule.Instance("ScrollingFrame",{
                    Parent = Dropdown;
                    Name = 'List';
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,20);
                    Size = UDim2.new(1,0,0,0);
                    CanvasSize = UDim2.new(0,0,0,0);
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    ScrollBarImageTransparency = 1;
                })


                local DropdownList = CreateModule.Instance("UIListLayout",{
                    Parent = List;
                    Padding = UDim.new(0,5);
                    HorizontalAlignment = Enum.HorizontalAlignment.Center;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                })

                CreateModule.Instance("Frame",{
                    Parent = List;
                    Name = 'ign';
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    Position = UDim2.new(0,0,0,0);
                    Size = UDim2.new(0,0,0,0);
                    LayoutOrder = -99999;
                })

                local Corner = CreateModule.Instance("UICorner",{
                    Parent = Dropdown;
                    Name = "Corner";
                    CornerRadius = UDim.new(0,5);
                })

                local Stroke = CreateModule.Instance("UIStroke",{
                    Parent = Dropdown;
                    Name = "Stroke";
                    Thickness = 1;
                    Color = Color3.fromRGB(40,40,40);
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                })

                local IsOpened = false

                DropdownButton.MouseButton1Click:Connect(function()
                    IsOpened = not IsOpened
                    if IsOpened then
                        Dropdown:TweenSize(UDim2.new(0.95,0,0,120),"Out","Quart",0.3,true)
                        List:TweenSize(UDim2.new(1,0,0,100),"Out","Quart",0.3,true)
                        TweenService:Create(DropdownImage,TweenInfo.new(0.3),{Rotation = 180}):Play()
                    else
                        Dropdown:TweenSize(UDim2.new(0.95,0,0,20),"Out","Quart",0.3,true)
                        List:TweenSize(UDim2.new(1,0,0,0),"Out","Quart",0.3,true)
                        TweenService:Create(DropdownImage,TweenInfo.new(0.3),{Rotation = 0}):Play()
                    end
                end)

                local Selected = {}

                local function NewSelectable(string,value)
                    local Selectable = CreateModule.Instance("TextButton",{
                        Parent = List;
                        Name = string;
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        BorderColor3 = Color3.fromRGB(40,40,40);
                        Position = UDim2.new(0,0,0,0);
                        Size = UDim2.new(0.95,0,0,20);
                        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                        Text = "  " .. string;
                        TextSize = 16;
                        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextYAlignment = Enum.TextYAlignment.Center;
                        AutoButtonColor = false;
                    })

                    local Check = CreateModule.Instance("TextLabel",{
                        Parent = Selectable;
                        Name = "Check";
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        Position = UDim2.new(0.88, 0, 0, 0);
                        Size = UDim2.new(0.1,0,0,20);
                        Font = Enum.Font[AtlasLib["Theme"]["Font"]];
                        Text = "";
                        TextSize = 16;
                        TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5);
                        TextXAlignment = Enum.TextXAlignment.Center;
                        TextYAlignment = Enum.TextYAlignment.Center;
                    })

                    local Corner = CreateModule.Instance("UICorner",{
                        Parent = Selectable;
                        Name = "Corner";
                        CornerRadius = UDim.new(0,5);
                    })
    
                    local Stroke = CreateModule.Instance("UIStroke",{
                        Parent = Selectable;
                        Name = "Stroke";
                        Thickness = 1;
                        Color = Color3.fromRGB(40,40,40);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    })

                    Selectable.MouseEnter:Connect(function()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{TextColor3 = AtlasLib["Theme"]["FontColor"]}):Play()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{BackgroundColor3 = Color3.fromRGB(32,32,37)}):Play()
                    end)
            
                    Selectable.MouseLeave:Connect(function()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{TextColor3 = Darker(AtlasLib["Theme"]["FontColor"],1.5)}):Play()
                        TweenService:Create(Selectable,TweenInfo.new(0.3),{BackgroundColor3 = Darker(Color3.fromRGB(32,32,37),1.15)}):Play()
                    end)

                    Selectable.MouseButton1Click:Connect(function()
                        Selected[string] = not Selected[string]
                        if Selected[string] then
                            Check.Text = "●"
                        else
                            Check.Text = ""
                        end
                        pcall(func, string, value)
                    end)
                end

                for string,value in next,Selectables do
                    if ind == 1 then
                        NewSelectable(tostring(string),tostring(value))
                    elseif ind == 2 then
                        NewSelectable(tostring(value),tostring(string))
                    end
                end

                local InDropdown = {}
                function InDropdown.Refresh(selec)
                    for i,v in next,List:GetChildren() do
                        if v.ClassName == "TextButton" then
                            v:Destroy()
                        end
                    end
                    wait()
                    Selected = {}
                    for string,value in next,selec do
                        if ind == 1 then
                            NewSelectable(tostring(string),tostring(value))
                        elseif ind == 2 then
                            NewSelectable(tostring(value),tostring(string))
                        end
                    end
                end
                AddToReg(Dropdown)
                return InDropdown;
            end

            return InSection;
        end
        return InPage;
	end
	return InMain;
end

return AtlasLib;
