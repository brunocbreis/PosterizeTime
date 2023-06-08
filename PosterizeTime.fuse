FuRegisterClass("PosterizeTime", CT_Tool, {
    REGS_Name = "PosterizeTime", 
    REGS_Category = "Fuses"
})


function Create()
    InFPS = self:AddInput("FPS", "FPS", {
        LINKID_DataType = "Number",
        INPID_InputControl = "SliderControl",
        INP_MaxScale = 24,
        INP_MinScale = .1,
        INP_Default = 12,
        INP_External = false, -- not animatable
    })
    
    InImage = self:AddInput("Input", "Input", {
        LINKID_DataType = "Image",
        LINK_Main = 1,
    })
    OutImage = self:AddOutput("Output", "Output", {
        LINKID_DataType = "Image",
        LINK_Main = 1,
    })

end




function OnAddToFlow()
    currentFPS = self.Comp:GetPrefs().Comp.FrameFormat.Rate
end


function Posterize(time, reqFPS)
    local fpsRatio = currentFPS / reqFPS
    return math.floor(time / fpsRatio) * fpsRatio
end


function Process(req)
    local reqFPS = InFPS:GetValue(req).Value
    local posterizedTime = Posterize(req.Time, reqFPS)

    local img = InImage:GetSource(posterizedTime)

    OutImage:Set(req, img)
end