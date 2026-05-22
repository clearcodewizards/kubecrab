module CssHelper
  def css_button
    "cursor-pointer inline-flex items-center justify-center rounded-md bg-red-400 px-3 py-2 text-sm font-semibold text-white shadow-xs " \
      "hover:bg-red-300 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-400 dark:shadow-none"
  end

  def css_button_small
    "cursor-pointer inline-flex items-center justify-center rounded-md bg-red-400 px-2 py-1.5 text-xs font-semibold text-white shadow-xs " \
      "hover:bg-red-300 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-400 dark:shadow-none"
  end

  def css_button_secondary
    "cursor-pointer inline-flex items-center justify-center rounded-md bg-white/10 px-3 py-2 text-sm font-semibold text-white shadow-xs " \
      "inset-ring inset-ring-white/5 hover:bg-white/20 dark:shadow-none"
  end

  def css_label
    "block text-sm/6 font-medium text-gray-900 dark:text-white"
  end

  def css_text
    "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 " \
      "focus:outline-2 focus:-outline-offset-2 focus:outline-red-400 sm:text-sm/6 dark:bg-white/5 dark:text-white dark:outline-white/10 " \
      "dark:placeholder:text-gray-500 disabled:cursor-not-allowed"
  end

  def css_password
    "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 " \
      "focus:outline-2 focus:-outline-offset-2 focus:outline-red-400 sm:text-sm/6 dark:bg-white/5 dark:text-white dark:outline-white/10 " \
      "dark:placeholder:text-gray-500 disabled:cursor-not-allowed"
  end

  def css_select
    "col-start-1 row-start-1 w-full appearance-none rounded-md bg-white py-1.5 pr-8 pl-3 text-base text-gray-900 outline-1 -outline-offset-1 " \
      "outline-gray-300 focus:outline-2 focus:-outline-offset-2 focus:outline-red-400 sm:text-sm/6 dark:bg-white/5 dark:text-white " \
      "dark:outline-white/10 dark:*:bg-gray-800"
  end

  def css_textarea
    "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 " \
      "focus:outline-2 focus:-outline-offset-2 focus:outline-red-400 sm:text-sm/6 dark:bg-white/5 dark:text-white dark:outline-white/10 " \
      "dark:placeholder:text-gray-500"
  end

  def css_check_box
    "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-red-400 checked:bg-red-400 " \
      "indeterminate:border-red-400 indeterminate:bg-red-400 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-400 " \
      "disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 dark:border-white/10 dark:bg-white/5 forced-colors:appearance-auto"
  end

  def css_link
    "font-semibold text-red-400 hover:text-red-300"
  end
end
