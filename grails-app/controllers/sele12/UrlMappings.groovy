package sele12

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

//        "/"(view:"/index")
        "/"(controller: "selenium", action: "index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
