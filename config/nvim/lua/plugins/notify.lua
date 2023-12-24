-- Plugin for having notifications just like
-- any other notification manager.

return {
    "rcarriga/nvim-notify",
    opts = {
        background_colour = "#000000",
        fps = 60,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 2500
    }
}
