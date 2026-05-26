#!/bin/bash

# Get the next upcoming event from Outlook calendar
osascript <<EOF
tell application "Microsoft Outlook"
    set currentDate to current date
    set nextEvent to missing value
    set nextEventTime to missing value

    -- Get all calendars
    set allCalendars to every calendar

    -- Search through all calendars for the next event
    repeat with cal in allCalendars
        try
            set calendarEvents to (every calendar event of cal whose start time > currentDate)

            repeat with evt in calendarEvents
                set evtStart to start time of evt

                if nextEvent is missing value then
                    set nextEvent to evt
                    set nextEventTime to evtStart
                else if evtStart < nextEventTime then
                    set nextEvent to evt
                    set nextEventTime to evtStart
                end if
            end repeat
        end try
    end repeat

    -- Return the next event details as JSON-like format
    if nextEvent is not missing value then
        set eventTitle to subject of nextEvent
        set eventStart to start time of nextEvent
        set eventEnd to end time of nextEvent

        -- Format date and time
        set startDate to date string of eventStart
        set startTime to time string of eventStart
        set endTime to time string of eventEnd

        -- Calculate time until event
        set timeUntil to (eventStart - currentDate)
        set minutesUntil to (timeUntil div 60) as integer
        set hoursUntil to (minutesUntil div 60) as integer
        set daysUntil to (hoursUntil div 24) as integer

        -- Build time until string
        set timeUntilStr to ""
        if daysUntil > 0 then
            set timeUntilStr to (daysUntil as string) & "d "
        else if hoursUntil > 0 then
            set timeUntilStr to (hoursUntil as string) & "h "
        else if minutesUntil > 0 then
            set timeUntilStr to (minutesUntil as string) & "m"
        else
            set timeUntilStr to "now"
        end if

        -- Return formatted output
        return "{\"title\":\"" & eventTitle & "\",\"date\":\"" & startDate & "\",\"start\":\"" & startTime & "\",\"end\":\"" & endTime & "\",\"until\":\"" & timeUntilStr & "\"}"
    else
        return "{\"title\":\"No upcoming events\",\"date\":\"\",\"start\":\"\",\"end\":\"\",\"until\":\"\"}"
    end if
end tell
EOF
