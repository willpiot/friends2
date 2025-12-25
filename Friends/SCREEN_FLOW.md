# Friends App - Screen Flow Documentation

## App Flow Overview

```
┌─────────────────┐
│  WelcomeView    │ → First launch only
│                 │
│ • App intro     │
│ • Research info │
│ • Mission       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   LoginView     │ → Account creation
│                 │
│ • Apple/Google  │
│ • X/Email/Phone │
│ • Profile info  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Questionnaire   │ → 50 questions
│     View        │
│                 │
│ • Likert scale  │
│ • 5 categories  │
│ • Progress bar  │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ PreferencesView │ → Schedule & prefs
│                 │
│ • Days/times    │
│ • Locations     │
│ • Age range     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  MatchesView    │ → Main app screen
│                 │
│ • Match cards   │
│ • Accept/Pass   │
│ • Upcoming dates│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  ProfileView    │ → Match details
│                 │
│ • Photo gallery │
│ • Demographics  │
│ • Match score   │
└─────────────────┘
```

## Screen Details

### 1. WelcomeView
**Purpose**: Introduce app and explain evidence-based approach

**Key Elements**:
- Heart icon with gradient
- "Welcome to Friends" title
- Four information cards:
  1. Evidence-Based Matching (pink) - Byrne et al. research
  2. Intelligent AI Matching (blue) - AI explanation
  3. Scheduled Real Dates (green) - 30-min dates
  4. Our Mission (purple) - Population decline solution
- "Get Started" button (pink)

**User Action**: Tap "Get Started" → proceeds to LoginView

---

### 2. LoginView
**Purpose**: Create account with multiple authentication options

**Key Elements**:
- Profile icon with gradient
- "Create Your Account" title
- Five login buttons:
  - Apple (black, apple logo)
  - Google (red, G logo)
  - X (black, X logo)
  - Email (blue, envelope)
  - Phone (green, phone)
- Expandable form fields:
  - Full Name
  - Age
  - Gender picker
  - Email/Phone (conditional)
- "Create Account" button (pink)

**User Action**: Complete form → proceeds to QuestionnaireView

---

### 3. QuestionnaireView
**Purpose**: 50-question personality and values assessment

**Key Elements**:
- Header with progress: "Personality Questionnaire 0/50"
- Progress bar (pink)
- Category badge (color-coded by category)
- Question text (large, bold)
- Five Likert scale buttons:
  - Strongly Disagree (1 pt = 5 weight)
  - Disagree (2 pt = 3 weight)
  - Neutral (3 pt = 1 weight)
  - Agree (4 pt = 3 weight)
  - Strongly Agree (5 pt = 5 weight)
- Navigation buttons:
  - "Previous" (gray, if not first question)
  - "Next" or "Complete" (pink, if answer selected)

**Categories**:
- Personality (blue) - 15 questions
- Attitudes (green) - 10 questions
- Beliefs (purple) - 10 questions
- Interests (orange) - 8 questions
- Deal-Breakers (red) - 7 questions

**User Action**: Answer all 50 questions → proceeds to PreferencesView

---

### 4. PreferencesView
**Purpose**: Set scheduling and matching preferences

**Key Elements**:
- "Set Your Preferences" title
- Six preference sections:

  1. **Available Days** (calendar icon)
     - Chip buttons for each day
     - Multi-select

  2. **Preferred Times** (clock icon)
     - Morning (8am-12pm)
     - Afternoon (12pm-5pm)
     - Evening (5pm-9pm)
     - Multi-select chips

  3. **Preferred Locations** (map icon)
     - Coffee Shop, Restaurant, Park, Bar, Museum
     - Multi-select chips

  4. **Age Range** (people icon)
     - Dual labels showing min/max
     - Range display (e.g., "Min: 21  Max: 35")

  5. **Maximum Distance** (location icon)
     - Slider (5-50 miles)
     - Display: "25 mi"

- "Save Preferences" button (pink)

**User Action**: Set preferences → proceeds to MatchesView with generated matches

---

### 5. MatchesView
**Purpose**: Display weekly matches and manage dates

**Key Elements**:
- Navigation bar with settings gear icon
- "Your Matches" title
- Greeting: "Hello, [Name]!"

**Two Sections**:

A. **New Matches** (if pending):
   - Match cards showing:
     - 3x2 photo grid (6 photos)
     - Name and age
     - Location and education icons
     - Match score percentage (pink)
     - Suggested date details:
       - Date & time
       - Location name
       - Duration (30 min)
     - Two buttons:
       - "Pass" (gray)
       - "Add to Calendar" (pink)

B. **Upcoming Dates** (if accepted):
   - Compact cards showing:
     - Profile photo (circular)
     - Name
     - Date and time
     - Location
     - Chevron for details

**Empty State**:
- Heart slash icon
- "No matches yet"
- "Check back soon for new matches!"

**User Actions**:
- Tap match card → opens ProfileView
- Tap "Pass" → declines match
- Tap "Add to Calendar" → accepts match, moves to Upcoming
- Tap settings → opens PreferencesView as sheet

---

### 6. ProfileView
**Purpose**: Detailed view of a specific match

**Key Elements**:
- Close button (top left)
- 3x2 photo grid (6 photos, larger)
- Name and age (large title)
- Match score badge (pink heart icon)
  - "87% Match" in pink
- Demographics section:
  - Hometown (location icon)
  - Education (graduation cap)
  - Spiritual Beliefs (sparkles icon)
  - Political Beliefs (flag icon)
- Suggested Date card:
  - Calendar icon + date
  - Clock icon + time
  - Map pin icon + location
  - Timer icon + duration
- "Why You Match" section:
  - Explanation of compatibility score
  - Reference to research
  - Note about AI analysis

**User Action**: View details, close when done

---

## Color Scheme

- **Primary**: Pink (#FF1B93) - used for main actions, accents
- **Categories**:
  - Personality: Blue
  - Attitudes: Green
  - Beliefs: Purple
  - Interests: Orange
  - Deal-Breakers: Red
- **Backgrounds**: System gray (.systemGray6)
- **Text**: Primary/Secondary system colors

## Typography

- **Large Title**: Screen titles
- **Title/Title2**: Section headers, names
- **Headline**: Card titles, button text
- **Body**: Main content text
- **Subheadline**: Supporting text
- **Caption**: Metadata, small labels

## UI Components

### Custom Components:
1. **LikertButton**: Questionnaire response button with weight display
2. **ToggleChip**: Multi-select pill button
3. **FlowLayout**: Custom layout for wrapping chips
4. **MatchCard**: Full match display card
5. **AcceptedMatchCard**: Compact upcoming date card
6. **LoginButton**: Stylized authentication buttons
7. **InfoRow**: Profile detail row with icon

### SF Symbols Used:
- heart.circle.fill, heart.fill, heart.slash
- person.circle.fill, person.fill, person.2
- brain.head.profile
- sparkles
- calendar, calendar.badge.clock
- heart.text.square
- applelogo, g.circle.fill, x.circle.fill
- envelope.fill, phone.fill
- location.fill, mappin.and.ellipse, mappin.circle
- graduationcap.fill
- clock, timer
- flag.fill
- gearshape.fill
- checkmark, xmark
- chevron.left, chevron.right

## Data Persistence

**Stored in UserDefaults**:
- Current user profile
- Has seen welcome flag
- Questionnaire answers
- Preferences
- Match statuses (accepted/declined)

**Memory Only**:
- Generated sample matches (regenerated on app launch)

## Sample Data

The app generates 3 sample matches on preferences completion:
1. Emma Wilson, 28, San Francisco
2. Michael Chen, 30, Seattle  
3. Sarah Johnson, 26, Portland

Each with:
- 6 placeholder photos (SF Symbol: person.fill)
- Complete profile information
- Calculated similarity score
- Suggested date proposal

## Navigation Patterns

- **Linear onboarding**: Welcome → Login → Questionnaire → Preferences
- **Main screen**: MatchesView with navigation to ProfileView
- **Settings sheet**: Access PreferencesView from MatchesView
- **Modal sheets**: ProfileView, updated PreferencesView
- **No back navigation**: Progressive flow, no return to onboarding
