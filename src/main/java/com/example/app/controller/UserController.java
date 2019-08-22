package com.example.app.controller;import com.example.app.domain.Role;import com.example.app.domain.User;import com.example.app.service.UserService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.security.access.prepost.PreAuthorize;import org.springframework.security.core.annotation.AuthenticationPrincipal;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.validation.BindingResult;import org.springframework.web.bind.annotation.*;import javax.validation.Valid;import java.util.Map;@Controller@RequestMapping("/user")public class UserController {    @Autowired    private UserService userService;    @PreAuthorize("hasAuthority('ADMIN')")    @GetMapping    public String userList(Model model) {        model.addAttribute("users", userService.findAll());        return "userList";    }    @PreAuthorize("hasAuthority('ADMIN')")    @GetMapping("{user}")    public String userEditForm(@PathVariable User user, Model model) {        model.addAttribute("user", user);        model.addAttribute("roles", Role.values());        return "userEdit";    }    @PreAuthorize("hasAuthority('ADMIN')")    @PostMapping    public String userSave(            @RequestParam Map<String, String> form,            @RequestParam String username,            @RequestParam("userId") User user    ) {        userService.saveUser(user, username, form);        return "redirect:/user";    }    @GetMapping("/profile")    public String getProfile(Model model, @AuthenticationPrincipal User user) {        model.addAttribute("username", user.getUsername());        model.addAttribute("email", user.getEmail());        return "profile";    }    @PostMapping("/profile")    public String updateProfile(            @AuthenticationPrincipal User user,            @RequestParam String password,            @RequestParam String password2,            @RequestParam String email,            Model model    ) {        if (password != null && password2 != null && !password.equals(password2)) {            model.addAttribute("passwordError", "Passwords are different");            model.addAttribute("email", user.getEmail());            model.addAttribute("username", user.getUsername());            return "profile";        }        if (!userService.updateProfile(user, password, password2, email)) {            model.addAttribute("email", user.getEmail());            model.addAttribute("username", user.getUsername());            return "profile";        }        model.addAttribute("message", "Changes have been saved!");        model.addAttribute("email", user.getEmail());        return "profile";    }}