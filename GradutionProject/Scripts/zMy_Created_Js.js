/*!
 * classie - class helper functions
 * from bonzo https://github.com/ded/bonzo
 * 
 * classie.has( elem, 'my-class' ) -> true/false
 * classie.add( elem, 'my-new-class' )
 * classie.remove( elem, 'my-unwanted-class' )
 * classie.toggle( elem, 'my-class' )
 */

/*jshint browser: true, strict: true, undef: true */
/*global define: false */

(function (window) {

    'use strict';

    // class helper functions from bonzo https://github.com/ded/bonzo

    function classReg(className) {
        return new RegExp("(^|\\s+)" + className + "(\\s+|$)");
    }

    // classList support for class management
    // altho to be fair, the api sucks because it won't accept multiple classes at once
    var hasClass, addClass, removeClass;

    if ('classList' in document.documentElement) {
        hasClass = function (elem, c) {
            return elem.classList.contains(c);
        };
        addClass = function (elem, c) {
            elem.classList.add(c);
        };
        removeClass = function (elem, c) {
            elem.classList.remove(c);
        };
    }
    else {
        hasClass = function (elem, c) {
            return classReg(c).test(elem.className);
        };
        addClass = function (elem, c) {
            if (!hasClass(elem, c)) {
                elem.className = elem.className + ' ' + c;
            }
        };
        removeClass = function (elem, c) {
            elem.className = elem.className.replace(classReg(c), ' ');
        };
    }

    function toggleClass(elem, c) {
        var fn = hasClass(elem, c) ? removeClass : addClass;
        fn(elem, c);
    }

    var classie = {
        // full names
        hasClass: hasClass,
        addClass: addClass,
        removeClass: removeClass,
        toggleClass: toggleClass,
        // short names
        has: hasClass,
        add: addClass,
        remove: removeClass,
        toggle: toggleClass
    };

    // transport
    if (typeof define === 'function' && define.amd) {
        // AMD
        define(classie);
    } else {
        // browser global
        window.classie = classie;
    }

})(window);

(function (win, doc, undefined) {
    var zturn = function (turn) {
        this.turn = turn
        this.zturn = $("#" + turn.id)
        this.X = 0
        this.zturnitem = this.zturn.children(".zturn-item")
        this.num_li = this.zturnitem.length//轮播元素个数 zturnPy为每个的偏移量
        this.zturnPy = turn.Awidth / (this.num_li - 1)
        this.init()
        this.turn_()
        return this
    }
    zturn.prototype = {
        constructor: zturn,
        init: function () {
            var _self = this;
            this.zturn.children(".zturn-item").each(function (index, element) {
                //index是第几个元素 X是选取的中间数 num_li是总数
                var rt = 1//1:右侧：-1：左侧
                if ((index - _self.X) > _self.num_li / 2 || (index - _self.X) < 0 && (index - _self.X) > (-_self.num_li / 2)) { rt = -1 }//判断元素左侧还是右侧
                var i = Math.abs(index - _self.X);//取绝对值
                if (i > _self.num_li / 2) { i = parseInt(_self.X) + parseInt(_self.num_li) - index; }//i:是左或者右的第几个
                if ((index - _self.X) < (-_self.num_li / 2)) { i = _self.num_li + index - _self.X }
                $(this).css({
                    'position': 'absolute',
                    'left': '50%',
                    'margin-left': -_self.turn.width / 2 + _self.zturnPy * rt * i + "px",
                    'z-index': _self.num_li - i,
                    'opacity': Math.pow(_self.turn.opacity, i),
                    'transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')',
                    '-webkit-transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')',
                    '-webkit-transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')',
                    '-moz-transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')',
                    '-ms-transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')',
                    '-o-transform': 'scale(' + Math.pow(_self.turn.scale, i) + ')'
                })
                $(this).attr("data_n", index)
            })
        },
        turn_: function () {
            var _self = this
            this.zturnitem.click(function () {
                _self.X = $(this).attr("data_n")
                _self.init()
            })
        },
        prev_: function () {
            var _self = this
            this.X--
            if (this.X < 0) { this.X = this.num_li - 1 }
            this.init()
        },
        next_: function () {
            var _self = this
            this.X++
            if (this.X >= this.num_li) { this.X = 0 }
            this.init()
        }
    }
    win.zturn = zturn;
}(window, document))

    /*!
     * classie - class helper functions
     * from bonzo https://github.com/ded/bonzo
     * 
     * classie.has( elem, 'my-class' ) -> true/false
     * classie.add( elem, 'my-new-class' )
     * classie.remove( elem, 'my-unwanted-class' )
     * classie.toggle( elem, 'my-class' )
     */

    /*jshint browser: true, strict: true, undef: true */
    /*global define: false */

//(function (window) {

//        'use strict';

//        // class helper functions from bonzo https://github.com/ded/bonzo

//        function classReg(className) {
//            return new RegExp("(^|\\s+)" + className + "(\\s+|$)");
//        }

//        // classList support for class management
//        // altho to be fair, the api sucks because it won't accept multiple classes at once
//        var hasClass, addClass, removeClass;

//        if ('classList' in document.documentElement) {
//            hasClass = function (elem, c) {
//                return elem.classList.contains(c);
//            };
//            addClass = function (elem, c) {
//                elem.classList.add(c);
//            };
//            removeClass = function (elem, c) {
//                elem.classList.remove(c);
//            };
//        }
//        else {
//            hasClass = function (elem, c) {
//                return classReg(c).test(elem.className);
//            };
//            addClass = function (elem, c) {
//                if (!hasClass(elem, c)) {
//                    elem.className = elem.className + ' ' + c;
//                }
//            };
//            removeClass = function (elem, c) {
//                elem.className = elem.className.replace(classReg(c), ' ');
//            };
//        }

//        function toggleClass(elem, c) {
//            var fn = hasClass(elem, c) ? removeClass : addClass;
//            fn(elem, c);
//        }

//        var classie = {
//            // full names
//            hasClass: hasClass,
//            addClass: addClass,
//            removeClass: removeClass,
//            toggleClass: toggleClass,
//            // short names
//            has: hasClass,
//            add: addClass,
//            remove: removeClass,
//            toggle: toggleClass
//        };

//        // transport
//        if (typeof define === 'function' && define.amd) {
//            // AMD
//            define(classie);
//        } else {
//            // browser global
//            window.classie = classie;
//        }

//    })(window);



//-----------jquery.flextext.js-------------//
/*
    此插件textarea的高度是 height:100%; 继承父元素的高度 ==> 父元素只有一个 position:relative; 用于定位textarea
    页面中加载完毕又添加了pre标签，pre标签是以块元素存在的并且不可见，但是占用空间，
    不像display:none;什么空间也不占。
    所以textarea父元素的高度是通过pre撑开的(在textarea里面写入文字，文字会被添加到pre底下的span标签里，以此来撑开pre的高度)

    要改变textarea初始化时的高度，只需改变pre的padding值即可，页面加载时pre里面添加<br />标签是为了让pre标签初始时有个高度
 */
(function ($) {

    // Constructor
    function FT(elem) {
        this.$textarea = $(elem);

        this._init();
    }

    FT.prototype = {
        _init: function () {
            var _this = this;

            // Insert wrapper elem & pre/span for textarea mirroring
            this.$textarea.wrap('<div class="flex-text-wrap" />').before('<pre class="pre"><span /><br /></pre>');

            this.$span = this.$textarea.prev().find('span');

            // Add input event listeners
            // * input for modern browsers
            // * propertychange for IE 7 & 8
            // * keyup for IE >= 9: catches keyboard-triggered undos/cuts/deletes
            // * change for IE >= 9: catches mouse-triggered undos/cuts/deletions (when textarea loses focus)
            this.$textarea.on('input propertychange keyup change', function () {
                _this._mirror();
            });

            // jQuery val() strips carriage return chars by default (see http://api.jquery.com/val/)
            // This causes issues in IE7, but a valHook can be used to preserve these chars
            $.valHooks.textarea = {
                get: function (elem) {
                    return elem.value.replace(/\r?\n/g, "\r\n");
                }
            };

            // Mirror contents once on init
            this._mirror();
        }

        // Mirror pre/span & textarea contents
        , _mirror: function () {
            this.$span.text(this.$textarea.val());
        }
    };

    // jQuery plugin wrapper
    $.fn.flexText = function () {
        return this.each(function () {
            // Check if already instantiated on this elem
            if (!$.data(this, 'flexText')) {
                // Instantiate & store elem + string
                $.data(this, 'flexText', new FT(this));
            }
        });
    };

})(jQuery);
//-----------jquery.flextext.js-------------//



try {
    /*
var zturn=function(turn){
						var self=this
						this.x=1
						var zturn=$("#"+turn.id)
						this.zturnitem=zturn.children(".zturn-item")
						var X=this.x//初始第一个 第一个是0
						var num_li=this.zturnitem.length//轮播元素个数 zturnPy为每个的偏移量
						var zturnPy=turn.Awidth/(num_li-1)  
						

						this.zturnitem.click(function(){
							var zX=$(this).attr("data_n")
								z_sort(turn,zX)
						
						})


						zturn.children(".zturn-item").each(function(index,element){
								//index是第几个元素 X是选取的中间数 num_li是总数
							var rt=1//1:右侧：-1：左侧
							if((index-X)>num_li/2||(index-X)<0&&(index-X)>(-num_li/2)){rt=-1}//判断元素左侧还是右侧
							var i=Math.abs(index-X);//取绝对值
							if(i>num_li/2){i=X+num_li-index}//i:是左或者右的第几个
							if((index-X)<(-num_li/2)){i=num_li+index-X}
							
							$(this).css({
								'position':'absolute',
								'left': '50%',
								'margin-left':-turn.width/2+zturnPy*rt*i+"px",
								'z-index':num_li-i,
								'opacity': Math.pow(turn.opacity,i),
								'transform':'scale('+Math.pow(turn.scale,i)+')',
								'-webkit-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-webkit-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-moz-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-ms-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-o-transform':'scale('+Math.pow(turn.scale,i)+')'
							})
							$(this).attr("data_n",index)
						})	
					}
					
				function z_sort(turn,X){
//						console.log(turn,X)
						var self=this
						var zturn=$("#"+turn.id)
						var zturnitem=zturn.children(".zturn-item")
						var num_li=zturnitem.length//轮播元素个数 zturnPy为每个的偏移量
						var zturnPy=turn.Awidth/(num_li-1)  

					
						zturn.children(".zturn-item").each(function(index,element){
					
						var rt=1//1:右侧：-1：左侧
							if((index-X)>num_li/2||(index-X)<0&&(index-X)>(-num_li/2)){rt=-1}//判断元素左侧还是右侧
							var i=Math.abs(index-X);//取绝对值
							if(i>num_li/2){i=parseInt(X)+num_li-index;}//i:是左或者右的第几个
							if((index-X)<(-num_li/2)){i=num_li+index-X}

							$(this).css({
								'position':'absolute',
								'left': '50%',
								'margin-left':-turn.width/2+zturnPy*rt*i+"px",
								'z-index':num_li-i,
								'opacity': Math.pow(turn.opacity,i),
								'transform':'scale('+Math.pow(turn.scale,i)+')',
								'-webkit-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-webkit-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-moz-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-ms-transform':'scale('+Math.pow(turn.scale,i)+')',
								'-o-transform':'scale('+Math.pow(turn.scale,i)+')'
							})
						})	
					
				}
				*/

} catch (e) {

}