class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
    # @sessions = Session.all
    @sessions = Session.select do |elem|
      elem.sessionDate
    end
    
  end

  # GET /sessions/1/edit
  def edit
    # @sessions = Session.includes(:sessionLength => :album).where('sessioncurrentSessionInList>=?','2013-01-01').references(:sessions)
    # @users = User.includes(:pins => :album).where('pins.date>=?','2013-01-01').references(:pins)
  end
  
  def addToHour(hour, modifier)
    if((hour + modifier) > 24)
      return (hour+modifier)-24
    end    
    
    return hour+modifier
  end
  
  def subtractFromHour(hour, modifier)
    if((hour - modifier) < 0)
      return (hour-modifier)+24
    end    
    
    return hour-modifier
  end
  
  def isValidSessionTime(newDate, openHour, closeHour, lunchHour, sessionLen)
    @sessions = Session.all
    newHourPlusSessionLength = addToHour(newDate.hour.to_i, sessionLen)
    newHourMinusSessionLen = subtractFromHour(newDate.hour.to_i, sessionLen)
    
    newDatePlusSessionLen  = Time.new(newDate.year, newDate.month, newDate.day, newHourPlusSessionLength, newDate.min)
    newDateMinusSessionLen = Time.new(newDate.year, newDate.month, newDate.day, newHourMinusSessionLen, newDate.min)
    
    print "__________________________________________________________________________________\n\n\n\n"
    sessionInProgressPreCheck = false, sessionInProgressPostCheck = false, sessionOutsideOfStoreHours = false
    @sessions.each do |s|
      #Each session in the list is stored as an ActiveSupport::TimeWithZone. Converting to a normal Time class for comparison
      year = s.sessionDate.year
      month = s.sessionDate.month
      day = s.sessionDate.day
      hour = s.sessionDate.hour
      min = s.sessionDate.min
      currentSessionInList = Time.new(year, month, day, hour, min)
      
      print "\n_________________________________________________________________________________\n"
      print currentSessionInList.class.to_s + " - " + newDate.class.to_s + "\n"
      print "currentSessionInList: " + currentSessionInList.to_i.to_s + " | " +  currentSessionInList.to_s + "\n"
      print "newDate: " + newDate.to_i.to_s + " | " +  newDate.to_s + "\n"
      print "newDateMinusSessionLen: " + newDateMinusSessionLen.to_i.to_s + " | " +  newDateMinusSessionLen.to_s + "\n"
      print "newDatePlusSessionLen: " + newDatePlusSessionLen.to_i.to_s + " | " +  newDatePlusSessionLen.to_s + "\n"
      
      sessionInProgressPreCheck = (currentSessionInList.to_i >= newDateMinusSessionLen.to_i) && (currentSessionInList.to_i <= newDate.to_i)
      print "sessionInProgressPreCheck : "  + sessionInProgressPreCheck.to_s + "\n"
      
      sessionInProgressPostCheck = (currentSessionInList.to_i >= newDate.to_i) && (currentSessionInList.to_i <= newDatePlusSessionLen.to_i)
      print "sessionInProgressPostCheck : " + sessionInProgressPostCheck.to_s + "\n"
      
      sessionOutsideOfStoreHours = (newDate.to_i < openHour.to_i) && (newDatePlusSessionsLen.to_i > closeHour.to_i)
      
      sessionDuringLunch = (newDate.to_i >= lunchHour.to_i) && (newDate.to_i < (lunchHour.to_i + 3600))
      
      if sessionInProgressPreCheck || sessionInProgressPostCheck || sessionOutsideOfStoreHours || sessionDuringLunch
        return true
      end
    end
    
    return false
  end
  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    newYear    = session_params["sessionDate(1i)"]; # year
    newMonth   = session_params["sessionDate(2i)"]; # month
    newDay     = session_params["sessionDate(3i)"]; # day
    newHour    = session_params["sessionDate(4i)"]; # hour
    newMin     = session_params["sessionDate(5i)"]; # minute
    sessionLen = session_params["sessionLength"];   # session length
    sessionLen = (sessionLen.to_i + 15)/60;         # 15 minute break between sessions
    
    newDate = Time.new(newYear, newMonth, newDay, newHour, newMin);
    
    #temporarily hardcoding open/close times. 
    openHour = Time.new(newYear, newMonth, newDay, 9, 0);
    closeHour = Time.new(newYear, newMonth, newDay, 21, 0);
    
    #temporarily hardcoding lunch hours
    lunchHour = Time.new(newYear, newMonth, newDay, 12, 0);
    
    validSessionTime = isValidSessionTime(newDate, openHour, closeHour, lunchHour, sessionLen)
    
    respond_to do |format|
      if validSessionTime
        format.html { render :new  }
        flash[:alert] = "Session unavailable at that time."
      else
        if @session.save
          format.html { redirect_to @session, notice: 'Session was successfully created.' }
          format.json { render :show, status: :created, location: @session }
        else
          format.html { render :new }
          format.json { render json: @session.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:bandName, :sessionDate, :sessionLength, :comments)
    end
end
