class HiringsController < ApplicationController

    def create
        hiring = Hiring.new(hiringParams)
        hiring.save
        redirect_to(:back)
    end

    def destroy
        blah
        Hiring.find(params[:id]).delete
    end

    private

        def hiringParams
            params.require(:hiring).permit(:student_id, :tutor_id)
        end
end
