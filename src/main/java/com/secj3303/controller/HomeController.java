package com.secj3303.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping({"/", "/landing", "/home"})
    public String landing(Model model) {
        return "/home"; 
    }
}