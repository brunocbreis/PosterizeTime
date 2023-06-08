FuRegisterClass("PosterizeTime", CT_Tool, {
    REGS_Name = "PosterizeTime",
    REGS_Category = "Fuses"
})


function Create()
    InFPS = self:AddInput("Frame Rate", "FPS", {
        LINKID_DataType = "Number",
        INPID_InputControl = "SliderControl",
        INP_MaxScale = 24,
        INP_MinScale = 1,
        INP_MaxAllowed = 24,
        INP_MinAllowed = 0.1,
        IC_DisplayedPrecision = 1,
        -- INP_Default = 12,
        INP_DelayDefault = true,
        INPS_StatusText = "Frame rate to simulate"
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
    CurrentFPS = self.Comp:GetPrefs().Comp.FrameFormat.Rate
    InFPS:SetAttrs({
        INP_Default = CurrentFPS/2,
        INP_MaxScale = CurrentFPS,
        INP_MaxAllowed = CurrentFPS,
    })
end


function Posterize(time, reqFPS)
    local fpsRatio = CurrentFPS / reqFPS
    return math.floor(time / fpsRatio) * fpsRatio
end


function Process(req)
    local reqFPS = InFPS:GetValue(req).Value

    if reqFPS == CurrentFPS then
        OutImage:Set(req, InImage:GetValue(req))
        return
    end

    local posterizedTime = Posterize(req.Time, reqFPS)

    local img = InImage:GetSource(posterizedTime)

    OutImage:Set(req, img)
end