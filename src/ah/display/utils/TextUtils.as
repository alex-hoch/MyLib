/**
 * TextUtils.
 * Date: 20.02.15
 * Time: 16:03
 * Alex Hoch
 */

/**
 * USING (all values is default):
 * var field:TextField = TextUtils.getNewTextField( {
					size		:		12,
					color		:		0x000000,
					selectable	:		true,
					bold		:		false,
					italic		:		false,
					wordWrap	:		false,
					multiline	:		false,
					autoSize	:		TextFieldAutoSize.NONE,
					type		:		TextFieldType.DYNAMIC,
					align		:		TextFormatAlign.LEFT
				} );
 */

package ah.display.utils {
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextUtils {
		//--------------------------------------------------------------------------
		//  Constants
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Variables
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Public properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Protected properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Private properties
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Constructor
		//--------------------------------------------------------------------------
		public function TextUtils() {

		}

		//--------------------------------------------------------------------------
		//  Public methods
		//--------------------------------------------------------------------------
		public static function getNewTextField(settings:Object):TextField {
			var result:TextField = new TextField();
			var fmt:TextFormat = new TextFormat();

			for (var p:String in settings) {
				if (fmt.hasOwnProperty(p)) {
					fmt[p] = settings[p];
				} else if (result.hasOwnProperty(p)) {
					result[p] = settings[p];
				}
			}
			result.defaultTextFormat = fmt;
			result.text = settings.text || '';
			return result;
		}

		//--------------------------------------------------------------------------
		//  Protected methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Private methods
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//  Handlers 
		//--------------------------------------------------------------------------
	}
}
