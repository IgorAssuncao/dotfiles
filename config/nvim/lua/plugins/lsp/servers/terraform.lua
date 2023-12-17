return function(opts)
    opts.filetypes = {
        "terraform",
        "terraform-vars",
        "tf",
        ".tf",
        "tfvars",
        ".tfvars",
        "*.tfvars*",
        "*.tfbackend",
        "terraformrc",
        ".terraformrc",
        "*.terraformrc",
        "tfrc",
        ".tfrc",
        "*.tfrc"
    }

    return opts
end
