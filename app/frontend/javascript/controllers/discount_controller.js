import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["discountPrice", "finalPrice", "rangeInput", "totalPrice"];

    connect() {
        this.observeTotalPrice();
    }

    observeTotalPrice() {
        const observer = new MutationObserver(() => {
            this.updateDiscount();
        });
        let counter = document.getElementById('count-price-item');
        observer.observe(counter, { childList: true, subtree: true });
    }

    updateDiscount() {
        this.discountPriceTarget.innerText = this.rangeInputTarget.value;
        const totalPrice = parseInt(this.totalPriceTarget.innerText);
        const newPrice = totalPrice - this.rangeInputTarget.value;
        this.finalPriceTarget.innerText = newPrice;
        document.querySelector('input[name="discount"]').value = this.rangeInputTarget.value;
    }
}