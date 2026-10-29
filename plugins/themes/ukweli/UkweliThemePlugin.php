<?php

/**
 * @file plugins/themes/ukweli/UkweliThemePlugin.php
 *
 * @brief Ukweli custom theme plugin for clean card-based layout.
 */

namespace APP\plugins\themes\ukweli;

use PKP\plugins\ThemePlugin;

class UkweliThemePlugin extends ThemePlugin
{
    /**
     * Determine whether the theme is active
     */
    public function isActive()
    {
        return true;
    }

    /**
     * Initialize the theme
     */
    public function init()
    {
        // Inherit all core templates from the default theme
        $this->setParent('defaultthemeplugin');

        // Register custom Ukweli design stylesheet
        $this->addStyle('ukweli-design', 'styles/theme.css');
    }

    /**
     * Get the display name of this theme
     */
    public function getDisplayName()
    {
        return 'Ukweli Modern Theme';
    }

    /**
     * Get the description of this theme
     */
    public function getDescription()
    {
        return 'Clean, modern card-based publishing theme for Ukweli Journal, removing legacy administrative bloat.';
    }
}
