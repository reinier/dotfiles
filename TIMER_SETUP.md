# Moneybird Timer Setup

## Configuration

1. Copy `hammerspoon/.secrets.json.template` to `hammerspoon/.secrets.json` (optional)
2. Optionally configure default timer description in the `moneybird` section:
   - `TIMER_DESCRIPTION`: Default description for timer entries (defaults to "Work Timer Entry")
   
   Note: API token, user account, client and project selection are all done via chooser interfaces on first use and stored locally in Hammerspoon settings.

## Usage

1. Press **F19** to open MenuHammer
2. Navigate to **Scripts** menu
3. Press **T** for "Start Timer"
4. **First time only**: Enter your Moneybird API token when prompted
5. **First time only**: Choose your user account from the user chooser
6. Choose a client from the keyboard-navigable client chooser (most recently used client at the top)
7. Choose a project from the keyboard-navigable project chooser
8. Enter timer description (prefilled with last used description)
9. Timer will start immediately with current UTC timestamp

- Success/error notifications will appear when needed

### Reset Timer Settings

If you need to reset stored timer data (user ID, client cache, etc.):

1. Press **F19** to open MenuHammer
2. Navigate to **Scripts** menu  
3. Press **R** for "Reset Timer Settings"
4. All locally stored timer data will be cleared including:
   - API token
   - User ID selection
   - Cached client list
   - Cached project list
   - Client usage statistics
   - Last used description
5. Next timer start will prompt for API token and re-fetch all data from the API

## API Integration

- Uses Moneybird API v2
- Prompts for API token on first use and stores it securely in Hammerspoon settings
- Fetches administration ID automatically
- Shows user chooser on first use (via `/users.json`) and stores selected user ID
- Fetches and caches clients (contacts) on first use, sorts by most recent usage
- Fetches and caches projects on first use for fast selection
- Caches client usage data (refreshes every hour)
- Creates billable time entries with selected client, project, and description
- Remembers last used description for quick re-entry
- Stores user preferences and cache data locally using Hammerspoon settings
- Handles errors gracefully with user-friendly messages

## Files Created

- `hammerspoon/functions/timer-api.lua` - Main API integration
- `hammerspoon/.secrets.json.template` - Configuration template
- Updated `hammerspoon/menus/scripts.lua` - Menu integration