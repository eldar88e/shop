import { application } from "./application"

import NoticesController from "./notices_controller"
application.register("notices", NoticesController)

import DiscountController from "./discount_controller"
application.register("discount", DiscountController)
