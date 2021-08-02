class MobileMenu {
	constructor() {
		this.DOM = {};
		this.DOM.btn = document.querySelector('.mobile-menu__btn');
		this.DOM.container = document.querySelector('#global-container');
		this._getEventType();
		this._addEvent();
	}

	// スマホかPCを判別してイベントを変更する
	_getEventType() {
		const isTouchCapable =
			"ontouchstart" in window ||
			(window.DocumentTouch && document instanceof window.DocumentTouch) ||
			navigator.maxTouchPoints > 0 ||
			window.navigator.msMaxTouchPoints > 0;

		return isTouchCapable ? 'touchstart' : 'click';
	}

	_toggle() {
		this.DOM.container.classList.toggle('menu-open');
	}

	_addEvent() {
		this.DOM.btn.addEventListener('click', this._toggle.bind(this));
	}
}

new MobileMenu();
