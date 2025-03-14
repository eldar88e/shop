// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AgreementController from "./application/agreement_controller"
application.register("agreement", AgreementController)

import DadataController from "./application/dadata_controller"
application.register("dadata", DadataController)

import ButtonsController from "./application/buttons_controller"
application.register("buttons", ButtonsController)

import PhoneMaskController from "./application/phone_mask_controller"
application.register("phone_mask", PhoneMaskController)

import NoticesController from "./application/notices_controller"
application.register("notices", NoticesController)

import RatingController from "./application/rating_controller"
application.register("rating", RatingController)

import MenuController from "./application/menu_controller"
application.register("menu", MenuController)

import CartController from "./application/cart_controller"
application.register("cart", CartController)

import OpenCartController from "./application/open_cart_controller"
application.register("open-cart", OpenCartController)

import VibrationController from "./application/vibration_controller"
application.register("vibration", VibrationController)
